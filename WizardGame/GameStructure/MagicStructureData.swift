//  MagicStructureData.swift
//  CodeNameWizard
//
//  Created by Enrico Brasiello on 24/06/24.
//  Creazione della struttura dati delle magie

import Foundation
import SpriteKit

struct MagicStructureData {
    var text: String
    var type: String
    var damage: Int
    var healing: Int
    var itCanBlock: Bool
    var imageAssociated: String
    var statusInfo: String
    var animation : SKAction?
}

// Creazione dell'elenco delle magie disponibili
let magicBook: [MagicStructureData] = [
    MagicStructureData(text: "Fire", type: "Offensive", damage: 25, healing: 0, itCanBlock: false, imageAssociated: "fireImage", statusInfo: "25 Damage",animation: fireballAction),
    
    MagicStructureData(text: "Heal", type: "Support", damage: 0, healing: 30, itCanBlock: false, imageAssociated: "healImage", statusInfo: "30 Healing power",animation: healAction),
    
    MagicStructureData(text: "Blizzard", type: "Counter", damage: 15, healing: 0, itCanBlock: true, imageAssociated: "freezeImage", statusInfo: "15 Damage. \n Freeze the enemy",animation: blizzardAction),
    
    MagicStructureData(text: "Lightning", type: "Offensive", damage: 50, healing: 0, itCanBlock: false, imageAssociated: "lightningImage", statusInfo: "Very powerful spell,\n shock the enemy",animation: thunderAction)
]
