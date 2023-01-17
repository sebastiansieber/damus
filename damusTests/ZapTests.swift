//
//  ZapTests.swift
//  damusTests
//
//  Created by William Casarin on 2023-01-16.
//

import XCTest
@testable import damus

final class ZapTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testZap() throws {
        let zapjson = "eyJpZCI6IjE4ZDFiYjIxMTQ1YWM4YTVhNjgxNGNlMzZjNDc3YTE4OTliNzc3YTgzNTQxNzgxZDUxMGRkMzAwZDEzNGQzNzQiLCJwdWJrZXkiOiI5NjMwZjQ2NGNjYTZhNTE0N2FhOGEzNWYwYmNkZDNjZTQ4NTMyNGU3MzJmZDM5ZTA5MjMzYjFkODQ4MjM4ZjMxIiwiY3JlYXRlZF9hdCI6MTY3MzgyNjc3OCwia2luZCI6OTczNSwidGFncyI6W1sicCIsIjMyZTE4Mjc2MzU0NTBlYmIzYzVhN2QxMmMxZjhlN2IyYjUxNDQzOWFjMTBhNjdlZWYzZDlmZDljNWM2OGUyNDUiXSxbImUiLCJlZjY4M2VmNzFhMWVlZjkzOTA4Y2U2NzQ3M2VjOTE2M2FhYWEyNGUxNTBmYzQ0YjE5NmM0ZGViNTk3OWMxYjE2Il0sWyJib2x0MTEiLCJsbmJjNTAwbjFwM3VmeXdxc3A1cW54NnRodHJhYWZxbmw0bjdhcTh2ZmU5ZGt1N2VkcGNya3Y4cmR6NDQyd2tnNDk5ZnpmcXBwNTM0eXo2NTBycWNtZ2Zua2c5bTVxejd6a2U0dDN0czAycXd2MGt0YW42cjI4Y2xtYzZ0NHFocDVrdDI3ZzRwdmwzdmtxZHZ5anA3N2hra3p4aGZzZTcwNXZzODB5eGx5bmNwOHJ6ZmF2Y3hzeHF5anc1cWNxcGpyempxdzVzdTc5bjQ0bTZ0N2ZneHJwbDM3N3J5eHR2ejZ0dXJzZmc4M3MwNGQ5bndramthNWUzZ3o3cDJ5cXE1anNxcXlxcXFxbGdxcXFxcXFncTlxOXF4cHF5c2dxMzJ6Znp1ZHdqdzRnMDBoM2hlbDlwdmZkODVlbG54cmZsNGFrNnAwNDVycmg3ZG51bmFseDB1cGs4Zm1uZTBjZnlsbGVsbWdodDdrNGZnajNncmt4N2swanp6eWM5MnhrcjB4ajVhZ3F0NGxzdWEiXSxbImRlc2NyaXB0aW9uIiwiW1tcInRleHQvcGxhaW5cIixcImpiNTUncyBsaWdodG5pbmcgYWRkcmVzc1wiXSxbXCJ0ZXh0L2lkZW50aWZpZXJcIixcImpiNTVAc2VuZHNhdHMubG9sXCJdLFtcImFwcGxpY2F0aW9uL25vc3RyXCIse1wiaWRcIjpcImNjYTE4MjNmMDlmN2YwZDA3ODBmMjgyMzc1OTkwN2U0MDY3MzZlOTliYmNmZGM2NDJjMTNiNjNhOGE2ZTE5OGNcIixcInB1YmtleVwiOlwiM2VmZGFlYmIxZDg5MjNlYmQ5OWM5ZTdhY2UzYjQxOTRhYjQ1NTEyZTJiZTc5YzFiN2Q2OGQ5MjQzZTBkMjY4MVwiLFwiY3JlYXRlZF9hdFwiOjE2NzM4MjY3NDcsXCJraW5kXCI6OTczNCxcInRhZ3NcIjpbW1wiZVwiLFwiZWY2ODNlZjcxYTFlZWY5MzkwOGNlNjc0NzNlYzkxNjNhYWFhMjRlMTUwZmM0NGIxOTZjNGRlYjU5NzljMWIxNlwiXSxbXCJwXCIsXCIzMmUxODI3NjM1NDUwZWJiM2M1YTdkMTJjMWY4ZTdiMmI1MTQ0MzlhYzEwYTY3ZWVmM2Q5ZmQ5YzVjNjhlMjQ1XCJdLFtcInJlbGF5c1wiLFwid3NzOi8vbm9zdHItcmVsYXkud2x2cy5zcGFjZVwiLFwid3NzOi8vbm9zdHItcHViLndlbGxvcmRlci5uZXRcIixcIndzczovL3JlbGF5Lm5vc3RyLmJnXCIsXCJ3c3M6Ly9ub3N0ci52MGwuaW9cIixcIndzczovL25vc3RyLm9yYW5nZXBpbGwuZGV2XCJdXSxcImNvbnRlbnRcIjpcInphcHBpbiB5b3Ugc29tZSBzYXRzIVwiLFwic2lnXCI6XCI3Mzk0OWViNDY4YjQ4MmUyMjU2Mjg1MGE5OTE4Njc4NmFjMjU1OWVhYzllNGRjYTJhMjk1NTI0YmIxODM2NGNlYmNiZmJkYzYyZTRkM2NkMTg1Yjc2YWUzZjZiM2UyZDYzMGFjMmE2ZmU2OGViOTg5YjM0MWYyMGZmNmNhZjg5NFwifV1dIl0sWyJwcmVpbWFnZSIsIjI1OWI1OGVjNmQ4MzVhZTFiZTUxMzI5NzQyMmZkMjY0NDNlNjA1MDg0ZTkyZmEzNTdkZDRlNTIyNjk0NDk4OGUiXV0sImNvbnRlbnQiOiJ6YXBwaW4geW91IHNvbWUgc2F0cyEiLCJzaWciOiJmOTkwM2E0YmI5MjNkYjIwM2EzOWNmNjBiZThlMDg2MmQyZTU2NzQ5OGYwYTZkZDk1NWJkYTA4OTg5OTcwMzA1NjJkNGZlZWRiYTFiOGRkYTI2NGU2NWQ3MTMyNmM5ZDkyOWRmYjY5OWI5NDg4ZmNlZTJjZjE4YjFjMzJkZDg3YSJ9Cg=="
        
        guard let json_data = Data(base64Encoded: zapjson) else {
            XCTAssert(false)
            return
        }
        
        let json_str = String(decoding: json_data, as: UTF8.self)
        
        guard let ev = decode_nostr_event_json(json: json_str) else {
            XCTAssert(false)
            return
        }
        
        guard let zap = Zap.from_zap_event(zap_ev: ev, zapper: "9630f464cca6a5147aa8a35f0bcdd3ce485324e732fd39e09233b1d848238f31") else {
            XCTAssert(false)
            return
        }
        
        XCTAssertEqual(zap.zapper, "9630f464cca6a5147aa8a35f0bcdd3ce485324e732fd39e09233b1d848238f31")
        XCTAssertEqual(zap.target, ZapTarget.note(id: "ef683ef71a1eef93908ce67473ec9163aaaa24e150fc44b196c4deb5979c1b16", author: zap.request.ev.pubkey))
    }

}
