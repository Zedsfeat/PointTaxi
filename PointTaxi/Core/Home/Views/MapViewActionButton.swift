//
//  MapViewActionButton.swift
//  PointTaxi
//
//  Created by zedsbook on 01.02.2023.
//

import SwiftUI

struct MapViewActionButton: View {
    
    @Binding var mapState: MapViewState
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    
    var body: some View {
        Button {
            withAnimation(.spring()) {
                actionForState(mapState)
            }
        } label: {
            Image(systemName: imageNameForState(mapState))
                .scaledToFit()
                .padding()
                .frame(height: 45)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(Color(.darkGray))
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: Color(.darkGray), radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)

    }
    
    func actionForState(_ state: MapViewState) {
        switch state {
        case .noInput:
            print("DEBUG: No input")
        case .locationSelected, .polylineAdded:
            withAnimation(.spring()) {
                mapState = .noInput
            }
            locationSearchViewModel.selectedTaxiLocation = nil
        case .searchingForLocation:
            break
        }
    }
    
    func imageNameForState(_ state: MapViewState) -> String {
        switch state {
        case .noInput:
            return "line.3.horizontal"
        case .searchingForLocation, .locationSelected, .polylineAdded:
            return "arrow.left"
            
        }
    }
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(mapState: .constant(.noInput))
    }
}
