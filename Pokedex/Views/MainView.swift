//
//  ContentView.swift
//  Pokedex
//
//  Created by Jerry Toland on 5/9/26.
//

import SwiftUI

struct MainView: View {
    
    @State var enteredPokemon: String = ""
    @State var pokeList: ListItem = ListItem()
    @State var pokemon: [Pokemon] = []
    
    
    let service = DataService()
    
    var body: some View {
        
        VStack {
            
            ZStack {
                
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundStyle(.tint)
                
                VStack {
                    
                    HStack {
                        Image(systemName: "circle.circle.fill")
                            .font(.title2)
                        
                        Text("Pokédex")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.white)
                    
                    HStack {
                        
                        TextField("Enter Pokemon name", text: $enteredPokemon)
                            .padding(8)
                            .autocorrectionDisabled()
                            .background(.white)
                        
                        Button {
                            // Trigger a search in the future
                        } label: {
                            
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(.white)
                                    .frame(width: 35, height: 35)
                                
                                Text("GO")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.tint)
                                
                            }
                            
                        }
                        
                    }
                    .padding()
                    
                }
                
            }
            .frame(height: 125)
            
            List {
                
                ForEach(pokemon, id: \.id) { p in
                    HStack {
                        
                        if let url = p.sprites?.frontDefault {
                         
                            AsyncImage(url: URL(string: url))
                            
                        } else {
                            
                            // TODO: Placeholder image
                            
                        }
                        
                        Text((p.name ?? "").capitalized)
                    }
                    .listRowSeparator(.hidden)
                }
                
            }
            .listStyle(.plain)
            
            HStack {
                
                Button {
                    
                    // TODO: back button functionality
                    
                } label: {
                    
                    Image(systemName: "arrow.left")
                    Text("Back")
                    
                }
                
                Spacer()
                
                Button {
                    
                    // TODO: forward button functionality
                    
                } label: {
                    
                    Text("Forward")
                    Image(systemName: "arrow.right")
                    
                }
                
            }
            .padding()
            
        }
        .task {
            
            pokeList = await service.getPokemonList()
            pokemon = await service.getPokemonFromList(list: pokeList)
            
        }
    }
}

#Preview {
    MainView()
}
