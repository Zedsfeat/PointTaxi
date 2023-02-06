//
//  HomeView.swift
//  PointTaxi
//
//  Created by zedsbook on 24.01.2023.
//

import SwiftUI

struct HomeView: View {
    
    @State private var mapState = MapViewState.noInput
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                TaxiMapViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()
                
                VStack {
                    
                    if mapState == .searchingForLocation {
                        LocationSearchView(mapState: $mapState)
                        
                    } else if mapState == .noInput {
                        LocationSearchActivationView()
                            .padding(.top, 20)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    mapState = .searchingForLocation
                                }
                            }
                    } else if mapState == .locationSelected || mapState == .polylineAdded {
                        MapViewActionButton(mapState: $mapState)
                            .padding(.top, 20)
                            .padding(.leading, 28)
                    }
                }
            }
            
            if mapState == .locationSelected || mapState == .polylineAdded {
                RideRequestView()
                    .transition(.move(edge: .bottom))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onReceive(LocationManager.shared.$userLocation) { location in
            if let location {
                locationSearchViewModel.userLocation = location
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
