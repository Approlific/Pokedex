//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Jerry Toland on 5/10/26.
//

import SwiftUI

struct PokemonDetailView: View {
    
    @Environment(PokemonViewModel.self) var model
    
    var body: some View {
        
        VStack {
            
            if let url = model.searchedPokemon.sprites?.frontDefault {
             
                // TODO: Resize Image
                AsyncImage(url: URL(string: url))
                    .frame(width: 256, height: 256)
                
            } else {
                
                Image("pokemon-not-found")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 256)
                
                
            }
            
            Text(model.searchedPokemon.name?.capitalized ?? "")
                .font(.title)
                .bold()
                .padding(.vertical, 8)
            
            HStack {
                
                Spacer()
                    
                Text("Height: \(model.searchedPokemon.height ?? 0) ft")
                
                Spacer()
                
                Text("Weight: \(model.searchedPokemon.weight ?? 0) lbs")
                
                Spacer()
                
            }
            
            // TODO: Add more data here
            
            Spacer()
            
        }
        .padding()
        
    }
}

#Preview {
    PokemonDetailView()
        .environment(PokemonViewModel())
}
