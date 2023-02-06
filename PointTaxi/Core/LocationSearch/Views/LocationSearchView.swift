//
//  LocationSearchView.swift
//  PointTaxi
//
//  Created by zedsbook on 01.02.2023.
//

import SwiftUI

struct LocationSearchView: View {
    
    @Binding var mapState: MapViewState
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    
    
    var body: some View {
        VStack {
            // Header
            LocationSearchHeaderView(mapState: $mapState)
            
            // List
            ScrollView {
                VStack {
                    ForEach(locationSearchViewModel.results, id: \.self) { result in
                        LocationSearchItemView(title: result.title, subtitle: result.subtitle)
                            .onTapGesture {
                                hideKeyboard()
                                locationSearchViewModel.selectLocation(result)
                                withAnimation(.spring()) {
                                    mapState = .locationSelected
                                }
                                locationSearchViewModel.queryFragment = ""
                                locationSearchViewModel.results = []
                                
                            }
                    }
                }
            }
            .padding(.vertical)
            
        }
        .background(Color.theme.backgroundColorWhiteToBlack)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(mapState: .constant(.searchingForLocation))
    }
}
