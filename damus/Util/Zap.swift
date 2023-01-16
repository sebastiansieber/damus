//
//  Zap.swift
//  damus
//
//  Created by William Casarin on 2023-01-15.
//

import Foundation

enum ZapSource {
    case author(String)
    // TODO: anonymous
    //case anonymous
}

enum ZapTarget: Equatable {
    case profile(String)
    case note(String)
}

struct ZapRequest {
    let ev: NostrEvent
}

struct Zap {
    public let invoice: ZapInvoice
    public let zapper: String /// zap authorizer
    public let target: ZapTarget
    public let request: ZapRequest
    
    public static func from_zap_event(zap_ev: NostrEvent, zapper: String) -> Zap? {
        /// Make sure that we only create a zap event if it is authorized by the profile or event
        guard zapper == zap_ev.pubkey else {
            return nil
        }
        guard let bolt11_str = event_tag(zap_ev, name: "bolt11") else {
            return nil
        }
        guard let bolt11 = decode_bolt11(bolt11_str) else {
            return nil
        }
        /// Any amount invoices are not allowed
        guard let zap_invoice = invoice_to_zap_invoice(bolt11) else {
            return nil
        }
        guard let preimage = event_tag(zap_ev, name: "preimage") else {
            return nil
        }
        guard preimage_matches_invoice(preimage, inv: zap_invoice) else {
            return nil
        }
        guard let desc = get_zap_description(zap_ev, inv_desc: zap_invoice.description) else {
            return nil
        }
        guard let zap_req = decode_zap_request(desc) else {
            return nil
        }
        guard let target = determine_zap_target(zap_req.ev) else {
            return nil
        }
        
        return Zap(invoice: zap_invoice, zapper: zapper, target: target, request: zap_req)
    }
}

/// Fetches the description from either the invoice, or tags, depending on the type of invoice
func get_zap_description(_ ev: NostrEvent, inv_desc: InvoiceDescription) -> String? {
    switch inv_desc {
    case .description(let string):
        return string
    case .description_hash(let deschash):
        guard let desc = event_tag(ev, name: "description") else {
            return nil
        }
        guard let data = desc.data(using: .utf8) else {
            return nil
        }
        guard sha256(data) == deschash else {
            return nil
        }
        
        return desc
    }
}

func invoice_to_zap_invoice(_ invoice: Invoice) -> ZapInvoice? {
    guard case .specific(let amt) = invoice.amount else {
        return nil
    }
    
    return ZapInvoice(description: invoice.description, amount: amt, string: invoice.string, expiry: invoice.expiry, payment_hash: invoice.payment_hash, created_at: invoice.created_at)
}

func preimage_matches_invoice<T>(_ preimage: String, inv: LightningInvoice<T>) -> Bool {
    guard let raw_preimage = hex_decode(preimage) else {
        return false
    }
    
    let hashed = sha256(Data(raw_preimage))
    
    return inv.payment_hash == hashed
}

func determine_zap_target(_ ev: NostrEvent) -> ZapTarget? {
    if let etag = event_tag(ev, name: "e") {
        return .note(etag)
    }
    
    if let ptag = event_tag(ev, name: "p") {
        return .profile(ptag)
    }
    
    return nil
}
                   
func decode_bolt11(_ s: String) -> Invoice? {
    var bs = blocks()
    bs.num_blocks = 0
    blocks_init(&bs)
    
    let bytes = s.utf8CString
    let _ = bytes.withUnsafeBufferPointer { p in
        damus_parse_content(&bs, p.baseAddress)
    }
    
    guard bs.num_blocks == 1 else {
        return nil
    }
    
    let block = bs.blocks[0]
    
    guard let converted = convert_block(block, tags: []) else {
        blocks_free(&bs)
        return nil
    }
    
    guard case .invoice(let invoice) = converted else {
        blocks_free(&bs)
        return nil
    }
    
    blocks_free(&bs)
    return invoice
}

func event_tag(_ ev: NostrEvent, name: String) -> String? {
    for tag in ev.tags {
        if tag.count >= 2 && tag[0] == name {
            return tag[1]
        }
    }
    
    return nil
}

func decode_zap_request(_ desc: String) -> ZapRequest? {
    let decoder = JSONDecoder()
    guard let jsonData = desc.data(using: .utf8) else {
        return nil
    }
    guard let jsonArray = try? JSONSerialization.jsonObject(with: jsonData) as? [[Any]] else {
        return nil
    }
    
    for array in jsonArray {
        let mkey = array.first.flatMap { $0 as? String }
        if let key = mkey, key == "application/nostr" {
            guard let dat = try? JSONSerialization.data(withJSONObject: array[1], options: []) else {
                return nil
            }
            
            guard let zap_req = try? decoder.decode(NostrEvent.self, from: dat) else {
                return nil
            }
            
            /// Ensure the signature on the zap request is correct
            guard case .ok = validate_event(ev: zap_req) else {
                return nil
            }
            
            return ZapRequest(ev: zap_req)
        }
    }
    
    return nil
}



func fetch_zapper_from_lnurl(_ lnurl: String) async -> String? {
    guard let url = decode_lnurl(lnurl) else {
        return nil
    }
    
    guard let ret = try? await URLSession.shared.data(from: url) else {
        return nil
    }
    
    let json_str = String(decoding: ret.0, as: UTF8.self)
    
    guard let endpoint: LNUrlPayRequest = decode_json(json_str) else {
        return nil
    }
    
    guard endpoint.allowsNostr else {
        return nil
    }
    
    guard endpoint.nostrPubkey.count == 64 else {
        return nil
    }
    
    return endpoint.nostrPubkey
}

func decode_lnurl(_ lnurl: String) -> URL? {
    guard let decoded = try? bech32_decode(lnurl) else {
        return nil
    }
    guard decoded.hrp == "lnurl" else {
        return nil
    }
    guard let url = URL(string: String(decoding: decoded.data, as: UTF8.self)) else {
        return nil
    }
    return url
}

