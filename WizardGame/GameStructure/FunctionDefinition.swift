//
//  FunctionDefinition.swift
//  CodeNameWizard
//
//  Created by Enrico Brasiello on 24/06/24.
//

import Foundation

func applyMagic(player: PlayerStructureData, opponent: PlayerStructureData, magic: MagicStructureData) -> String {
    // Verifica se il giocatore ha abbastanza mana
    if !player.useMana(Double(magic.manaCost)) {
        return "Not enough mana!"
    }

    var result = ""

    // Applica il danno se la magia è offensiva, quindi con un valore maggiore di 0
    if magic.damage > 0 {
        opponent.applyDamage(magic.damage)
        result += "\(player) does \(magic.damage) damage to \(opponent).\n"
    }
    // Applica la guarigione se la magia è di supporto
    if magic.healing > 0 {
        player.heal(magic.healing)
        result += "\(player) heals \(magic.healing) health points.\n"
    }
    // Applica il blocco se la magia può bloccare
    if magic.itCanBlock {
        opponent.isBlocked = true
        result += "\(opponent) is blocked.\n"
    }
    return result
}




