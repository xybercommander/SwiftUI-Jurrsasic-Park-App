//
//  PredatorMap.swift
//  JurassicPark
//
//  Created by Samrat Mukherjee on 29/04/24.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    let predators = Predators()
    @State var satellite = false
    @State var position: MapCameraPosition
    
    var body: some View {
        Map(position: $position) {
            //MARK: Annotations for all the Dinos in the map
            ForEach(predators.apexPredators) { predator in
                Annotation(predator.name, coordinate: predator.location) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(color: .white, radius: 7)
                        .scaleEffect(x: -1)
                }
            }
        }
        .mapStyle(satellite ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        .preferredColorScheme(.dark)
        .toolbarBackground(.hidden)
        .overlay(alignment: .bottomTrailing) {
            Button {
                satellite.toggle()
            } label: {
                Image(systemName: satellite ? "globe.americas.fill" : "globe.americas")
                    .imageScale(.large)
                    .font(.largeTitle)
                    .padding(3)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 7))
                    .shadow(radius: 7)
                    .padding()
            }
        }
    }
}

#Preview {
    NavigationStack {
        PredatorMap(position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[2].location, distance: 1000, heading: 250, pitch: 80)))
    }
}
