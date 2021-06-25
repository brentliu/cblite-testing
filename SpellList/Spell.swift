//
//  Spell.swift
//  SpellList
//
//  Created by Brent Liu on 6/22/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Spell
struct Spell: Codable, Identifiable {
    let id = UUID()
    
    let castingTime: String
    let classes: [PlayerClass]
    let components: Components
    let description, duration, level, name: String
    let range: String
    let ritual: Bool
    let school: School
    let tags: [PlayerClass]
    let type: String
    let higherLevels: String?

    enum CodingKeys: String, CodingKey {
        case castingTime = "casting_time"
        case classes, components
        case description = "description"
        case duration, level, name, range, ritual, school, tags, type
        case higherLevels = "higher_levels"
    }
    
    func getStringDisplay() -> String {
        "\(name) \(description) \(level) \(school.rawValue)"
    }
    
    static var sampleSpell: Spell {
        get {
            SpellListViewModel().spells.first!
        }
    }
    
    var spellType: String {
        get {
            let school = school.rawValue.capitalized
            switch level {
            case "cantrip":
                return "\(school) Cantrip"
            case "1":
                return "1st Level \(school)"
            case "2":
                return "2nd Level \(school)"
            case "3":
                return "3rd Level \(school)"
            default:
                return "\(level)th Level \(school)"
            }
        }
    }
    
    var classesString: String {
        get {
            return classes.map({$0.rawValue.capitalized}).joined(separator: ", ")
        }
    }
}

enum PlayerClass: String, Codable {
    case bard = "bard"
    case cantrip = "cantrip"
    case cleric = "cleric"
    case clericTrickery = "cleric (trickery)"
    case druid = "druid"
    case level1 = "level1"
    case level2 = "level2"
    case level3 = "level3"
    case level4 = "level4"
    case level5 = "level5"
    case level6 = "level6"
    case level7 = "level7"
    case level8 = "level8"
    case level9 = "level9"
    case paladin = "paladin"
    case ranger = "ranger"
    case sorcerer = "sorcerer"
    case warlock = "warlock"
    case wizard = "wizard"
}

// MARK: - Components
struct Components: Codable {
    let material: Bool
    let raw: String
    let somatic, verbal: Bool
    let materialsNeeded: [String]?

    enum CodingKeys: String, CodingKey {
        case material, raw, somatic, verbal
        case materialsNeeded = "materials_needed"
    }
}

enum School: String, Codable {
    case abjuration = "abjuration"
    case conjuration = "conjuration"
    case divination = "divination"
    case enchantment = "enchantment"
    case evocation = "evocation"
    case illusion = "illusion"
    case necromancy = "necromancy"
    case transmutation = "transmutation"
}

