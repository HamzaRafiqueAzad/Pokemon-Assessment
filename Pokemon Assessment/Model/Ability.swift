//
//  Ability.swift
//  Pokemon Assessment
//
//  Created by Hamza Rafique Azad on 25/11/23.
//

import Foundation

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
