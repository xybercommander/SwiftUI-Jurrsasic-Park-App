//
//  ContentView.swift
//  JurassicPark
//
//  Created by Samrat Mukherjee on 23/04/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let predators = Predators()
    @State var searchText = ""
    @State var alphabeticalSort = false
    @State var currentPredatorType = PredatorType.all
    
    //MARK: Logic for filtering Predators
    // filter first
    // sort second
    // search third
    var filteredDinos: [ApexPredator] {
        predators.filter(by: currentPredatorType)
        predators.sort(by: alphabeticalSort)
        return predators.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List(filteredDinos) { predator in
                NavigationLink {
                    PredatorDetail(predator: predator, position: .camera(MapCamera(centerCoordinate: predator.location, distance: 30000)))
                } label: {
                    HStack {
                        // Dinosaur Image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        
                        VStack(alignment: .leading) {
                            // Name
                            Text(predator.name)
                                .fontWeight(.bold)
                            
                            // Type
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText) // animates the filtering
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        //MARK: Adding animation to the sorting
                        withAnimation {
                            alphabeticalSort.toggle()
                        }
                    } label: {
                        Image(systemName: alphabeticalSort 
                              ? "film"
                              : "textformat")
                            .foregroundColor(.white)
                            .symbolEffect(.bounce, value: alphabeticalSort) // Enables animation when we tap the button
                            .sensoryFeedback(.success, trigger: alphabeticalSort)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currentPredatorType.animation()) {
                            ForEach(PredatorType.allCases) { type in
                                Label(
                                    type.rawValue.capitalized,
                                    systemImage: type.icon
                                )
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
