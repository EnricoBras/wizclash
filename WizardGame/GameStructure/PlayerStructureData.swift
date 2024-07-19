//
//  PlayerStructureData.swift
//  CodeNameWizard
//
//  Created by Enrico Brasiello on 24/06/24.


// Creazione delle variabili globali player da utilizzare nel gioco


import Foundation

class PlayerStructureData {
    var health: Double
    var damage: Int
    var isBlocked: Bool
    var hasBlocked : Bool

    // Metodo per resettare i dati del giocatore quando la partita termina.
    func resetPlay() {
        self.health = 150.0
        self.damage = 0
        self.isBlocked = false
        self.hasBlocked = false
    }

    // Metodo per applicare danni
    func applyDamage(_ amount: Int) {
        self.health -= Double(amount)
    }

    // Metodo per applicare guarigione
    func heal(_ amount: Int) {
        self.health += Double(amount)
    }

    

    

    // Inizializzatore che imposta i valori di default
    init() {
        self.health = 150.0
        self.damage = 0
        self.isBlocked = false
        self.hasBlocked = false
    }
}
