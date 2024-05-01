//
//  PredatorDetail.swift
//  JurassicPark
//
//  Created by Samrat Mukherjee on 28/04/24.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    let predator: ApexPredator
    
    @State var position: MapCameraPosition
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    //MARK: Background Image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(
                                        color: .clear,
                                        location: 0.8
                                    ),
                                    Gradient.Stop(
                                        color: .black,
                                        location: 1
                                    ),
                                ], startPoint: .top, endPoint: .bottom)
                        }
                    
                    //MARK: Dino Image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: geo.size.width / 1.5,
                            height: geo.size.height / 3)
                        .scaleEffect(x: -1) // Rotation of the dino like a mirror effect
                        .shadow(color: .black, radius: 7)
                        .offset(y: 20)
                    
                }
                
                VStack(alignment: .leading) {
                    //MARK: Dino Name
                    Text(predator.name)
                        .font(.largeTitle)
                    
                    //MARK: Current Location
                    //MARK: Map
                    NavigationLink {
                        PredatorMap(position: .camera(MapCamera(centerCoordinate: predator.location, distance: 30000)))
                    } label: {
                        Map(position: $position) {
                            Annotation(
                                predator.name,
                                coordinate: predator.location) {
                                    Image(systemName: "mappin.and.ellipse")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .symbolEffect(.pulse)
                                }
                                .annotationTitles(.hidden)
                        }
                        .frame(height: 125)
                        .clipShape(.rect(cornerRadius: 15))
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 10)
                        }
                        .overlay(alignment: .topLeading) {
                            Text("Current Location")
                                .padding([.leading, .bottom], 5)
                                .padding(.trailing, 8)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius: 15))
                        }
                    }
                    
                    //MARK: Appears In
                    Text("Appears in: ")
                        .font(.title3)
                        .padding(.top)
                    
                    ForEach(predator.movies, id: \.self) { movie in
                        Text("• " + movie)
                            .font(.subheadline)
                    }
                    
                    //MARK: Movie moments
                    Text("Movie Moments:")
                        .font(.title)
                        .padding(.top, 15)
                    
                    ForEach(predator.movieScenes) { movie in
                        Text(movie.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        Text(movie.sceneDescription)
                            .padding(.bottom, 15)
                    }
                    
                    //MARK: Link to webpage
                    Text("Read more:")
                        .font(.caption)
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
                .padding()
                .padding(.bottom)
                .frame(width: geo.size.width, alignment: .leading)
            }
            .ignoresSafeArea()
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    NavigationStack {
        PredatorDetail(predator: Predators().apexPredators[2], position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[2].location, distance: 30000)))
            .preferredColorScheme(.dark)
    }
}
