//
//  BrentTabView.swift
//  SpellList
//
//  Created by Brent Liu on 6/23/21.
//

import SwiftUI

struct BrentTabView: View {
    var body: some View {
        TabView {
            SpellListView()
                .tabItem {
                    Label("Spell List", systemImage: "list.dash")
                }
            BrentView2()
                .tabItem {
                    Label("BrentView2", systemImage: "square.and.pencil")
                }
        }
    }
}

struct BrentTabView_Previews: PreviewProvider {
    static var previews: some View {
        BrentTabView()
    }
}
