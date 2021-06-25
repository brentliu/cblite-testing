//
//  ShortSpellView.swift
//  SpellList
//
//  Created by Brent Liu on 6/22/21.
//

import SwiftUI

struct ShortSpellView: View {
    let spell: Spell
    
    init (_ spell: Spell) {
        self.spell = spell
    }
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                makeText(spell.name, DrawingConstants.nameFont)
                HStack {
                    makeText(spell.spellType, DrawingConstants.spellTypeFont)
                }
                Spacer()
            }.padding()
            Spacer()
        }
    }
    
    func makeText(_ str: String, _ font: Font) -> some View {
        Text(str).font(font).lineLimit(nil)
    }
    
    private struct DrawingConstants {
        static let nameFont = Font.headline
        static let spellTypeFont = Font.system(size: 10)
    }
}

struct SpellView_Previews: PreviewProvider {
    static var previews: some View {
        ShortSpellView(Spell.sampleSpell)
    }
}
