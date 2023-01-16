//
//  LNUrl.swift
//  damus
//
//  Created by William Casarin on 2023-01-16.
//

import Foundation

struct LNUrlPayRequest: Decodable {
    let allowsNostr: Bool
    let nostrPubkey: String
}
