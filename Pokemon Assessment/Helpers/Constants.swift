//
//  Constants.swift
//  Pokemon Assessment
//
//  Created by Hamza Rafique Azad on 25/11/23.
//

import Foundation

struct Constants {
    
    struct UserDetails {
        static let userName = "userName"
        static let email = "email"
    }
    
    struct Urls {
        static let pokeApi = "https://pokeapi.co/api/v2/pokemon?limit=10&offset="
    }
    
    struct UICells {
        static let pokemonTableViewCell = "PokemonTableViewCell"
        static let detailsTableViewCell = "DetailsTableViewCell"
    }
    
    struct UIViewControllers {
        static let homeViewController = "HomeViewController"
        static let detailsViewController = "DetailsViewController"
    }
}
