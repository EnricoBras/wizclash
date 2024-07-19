//
//  StartingGameBackEnd.swift
//  CodeNameWizard
//
//  Created by Enrico Brasiello on 30/06/24.
//
import Foundation

// Simula un turno di gioco
func gameTurn(player1: PlayerStructureData, player2: PlayerStructureData, player1Magic: MagicStructureData, player2Magic: MagicStructureData) {
    
    
    // Applica la magia del giocatore 1
    
    
    if !player1.isBlocked {
        let result1 = applyMagic(player: player1, opponent: player2, magic: player1Magic)
        print(result1)
    } else {
        print("\(player1) is blocked and cannot move.")
        player1.isBlocked = false
    }

    // Applica la magia del giocatore 2
    if !player2.isBlocked {
        let result2 = applyMagic(player: player2, opponent: player1, magic: player2Magic)
        print(result2)
    } else {
        print("\(player2) is blocked and cannot move.")
        player2.isBlocked = false
    }
}

