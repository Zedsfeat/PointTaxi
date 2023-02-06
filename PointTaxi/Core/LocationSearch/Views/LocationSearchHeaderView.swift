//
//  LocationSearchHeaderView.swift
//  PointTaxi
//
//  Created by zedsbook on 01.02.2023.
//

import SwiftUI

struct LocationSearchHeaderView: View {
    
    enum FocusField: Hashable { case field }
    @FocusState private var focusedField: FocusField?

    @Binding var mapState: MapViewState
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    @State private var startLocationText = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        // Header
        HStack(spacing: 15) {
            VStack {
                Circle()
                    .fill(Color(.systemGray3))
                    .frame(width: 8)
                
                Rectangle()
                    .fill(Color(.systemGray3))
                    .frame(width: 2, height: 30)
                
                Circle()
                    .fill(Color.theme.backgroundColorBlackToWhite)
                    .frame(width: 8)
            }
            
            VStack(spacing: 15) {
                
                HStack(spacing: 15) {
                    TextField("Current location", text: $startLocationText)
                        .padding(.leading, 7)
                        .frame(height: 37)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(.systemGray6))
                        )
                        .padding(.leading, 5)
                    
                    Button {
                        withAnimation(.spring()) {
                            hideKeyboard()
                            mapState = .noInput
                        }
                        locationSearchViewModel.queryFragment = ""
                        locationSearchViewModel.results = []
                    } label: {
                        Text("Close")
                            .foregroundColor(Color.theme.backgroundColorWhiteToBlack)
                            .frame(width: 60, height: 37)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.theme.backgroundColorBlackToWhite)
                            )
                    }
                }
                
                TextField("Where to?", text: $locationSearchViewModel.queryFragment)
                    .padding(.leading, 7)
                    .frame(height: 37)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(.systemGray3))
                    )
                    .padding(.leading, 5)
                    .focused($focusedField, equals: .field)
                    .onAppear { self.focusedField = .field }
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

//struct LocationSearchHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationSearchHeaderView(mapState: .constant(.locationSelected))
//    }
//}
