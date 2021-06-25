//
//  SpellListView.swift
//  SpellListView
//
//  Created by Brent Liu on 6/22/21.
//

import SwiftUI

struct SpellListView: View {
    let viewModel = SpellListViewModel()
    @State var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                List(viewModel.spells.filter({searchText.isEmpty ? true : $0.name.contains(searchText)})) { spell in
                    NavigationLink (destination: DetailedSpellView(spell)) {
                        ShortSpellView(spell)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SpellListView()
    }
}
