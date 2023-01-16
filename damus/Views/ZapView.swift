//
//  ZapView.swift
//  damus
//
//  Created by William Casarin on 2023-01-15.
//

import SwiftUI

struct ZapView: View {
    let damus_state: DamusState
    let zap: Zap
    let event: NostrEvent
    
    var body: some View {
        HStack {
            let pmodel = ProfileModel(pubkey: zap.request.ev.pubkey, damus: damus_state)
            let followers = FollowersModel(damus_state: damus_state, target: zap.request.ev.pubkey)
            let pv = ProfileView(damus_state: damus_state, profile: pmodel, followers: followers)
            
            NavigationLink(destination: pv) {
                ProfilePicView(pubkey: zap.request.ev.pubkey, size: PFP_SIZE, highlight: .none, profiles: damus_state.profiles)
            
                    let profile = damus_state.profiles.lookup(id: zap.request.ev.pubkey)
                    ProfileName(pubkey: zap.request.ev.pubkey, profile: profile, damus: damus_state, show_friend_confirmed: false, show_nip5_domain: false)
            }
            .buttonStyle(PlainButtonStyle())
            
            Text("⚡️ \(format_sats(zap.invoice.amount))")
                .font(Font.headline)
        }
    }
}

/*
 struct ZapView_Previews: PreviewProvider {
 static var previews: some View {
 ZapView(damus_state: test_damus_state(), zap: test_zap)
 }
 }
 */
