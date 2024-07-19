//
//  Message.swift
//  MultipeerExample
//
//  Created by Luigi gallo on 01/07/24.
//

import Foundation

enum Magic: Int, Codable {
    case fire
    case heal
    case blizzard
    case lightning
    case startClient
    case okClient
}


struct Message: Codable {
    let action: Magic
    
    func toData() -> Data? {
        var data: Data? = nil
        do {
            data = try JSONEncoder().encode(self)
        } catch {
            print("An error occured")
        }
        
        return data
    }
    
    static func toMessage(from data: Data) -> Message? {
        try? JSONDecoder().decode(Message.self, from: data)
    }
}
