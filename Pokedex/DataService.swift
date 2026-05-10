//
//  DataService.swift
//  Pokedex
//
//  Created by Jerry Toland on 5/9/26.
//

import Foundation
import SwiftUI

struct DataService {
    
    func getPokemonFromList(list: ListItem) async -> [Pokemon] {
        
        var pokemonList: [Pokemon] = []
        
        for i in list.pokeList ?? [] {
            
            // Get Pokemon name from list
            if let name = i.name {
                
                let pokemon = await getPokemon(name: name)
                
                pokemonList.append(pokemon)
            }
            
        }
        
        return pokemonList
        
    }
    
    func getPokemon(name: String) async -> Pokemon {
        
        // 1. URL
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(name)")
        
        do {
            
            // URLSession
            let (data, _) = try await URLSession.shared.data(from: url!)
            
            // Parse JSON
            let decoder = JSONDecoder()
            
            let searchResponse = try decoder.decode(Pokemon.self, from: data)
            
            return searchResponse
            
        } catch {
            
            print(error)
            
        }
        
        return Pokemon(id: 0, name: "Pokemon Not Found")
        
    }
    
    func getPokemonList(limit: Int, offset: Int) async -> ListItem {
        
        // 1. URL
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=\(limit)&offset=\(offset)") else { return ListItem() }
        
        do {
                
            // 3. URLSession
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Parse JSON
            let decoder = JSONDecoder()
            
            let searchResponse = try decoder.decode(ListItem.self, from: data)
            
            return searchResponse
            
        } catch {
            
            print(error)
            
        }
        
        return ListItem()
        
    }
    
    func getPokemonType() async {
        
        // TODO: filter by type then call getPokemonList on that
        
    }
    
}
