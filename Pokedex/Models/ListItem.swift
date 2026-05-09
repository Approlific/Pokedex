//
//  List.swift
//  Pokedex
//
//  Created by Jerry Toland on 5/9/26.
//

import Foundation

struct ListItem: Decodable {
    
    var count: Int?
    var next: String?
    var pokeList: [PokeList]?
    
    enum CodingKeys: String, CodingKey {
        
        case pokeList = "results"
        
        case count
        case next
        
    }
    
}

struct PokeList: Decodable {
    
    var name: String?
    
}
