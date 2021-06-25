//
//  DetailedSpellView.swift
//  SpellList
//
//  Created by Brent Liu on 6/22/21.
//

import SwiftUI

struct DetailedSpellView: View {
    let spell: Spell
    
    init (_ spell: Spell) {
        self.spell = spell
    }
    
    var body: some View {
        List {
            Text(spell.name)
            Text(spell.spellType)
            VStack(alignment: .leading) {
                Text("Casting Time: \(spell.castingTime)")
                Text("Range/Area: \(spell.range)")
                Text("Components: \(spell.components.raw)")
                Text("Duration: \(spell.duration)")
            }
            Text(spell.description)
            Text("Classes: \(spell.classesString)")
        }
    }
    
    private struct DrawingConstants {
        
    }
}

struct DetailedSpellView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedSpellView(Spell.sampleSpell)
    }
}
