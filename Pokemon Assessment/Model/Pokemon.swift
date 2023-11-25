//
//  Pokemon.swift
//  Pokemon Assessment
//
//  Created by Hamza Rafique Azad on 25/11/23.
//

import Foundation

struct Pokemon {
    
    let name: String
    let image: String
    var abilities: [Ability] = []
    var moves: [Move] = []
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    init(dict: [String: Any]) {
        self.name = dict["name"] as? String ?? ""
        self.image = (dict["sprites"] as? [String: Any])?["front_shiny"] as? String ?? ""
        if let abilities = dict["abilities"] as? [[String: Any]] {
            for ability in abilities {
                self.abilities.append(Ability(dict: ability["ability"] as? [String : Any] ?? [:]))
            }
        }
        
        if let moves = dict["moves"] as? [[String: Any]] {
            for move in moves {
                self.moves.append(Move(dict: move["move"] as? [String : Any] ?? [:]))
            }
        }
    }
}

struct Ability {
    let name: String
    let url: String
    
    init(name: String, slot: String, url: String) {
        self.name = name
        self.url = url
    }
    
    init(dict: [String: Any]) {
        self.name = dict["name"] as? String ?? ""
        self.url = dict["url"] as? String ?? ""
    }
}

struct Move {
    let name: String
    let url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
    init(dict: [String: Any]) {
        self.name = dict["name"] as? String ?? ""
        self.url = dict["url"] as? String ?? ""
    }
}
