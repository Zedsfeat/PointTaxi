//
//  RideRequestView.swift
//  Navigator
//
//  Created by zedsbook on 04.02.2023.
//

import SwiftUI

struct RideRequestView: View {
    
    @State private var selectedRidyType: RideType = .economy
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    
    var body: some View {
        VStack(spacing: 15) {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 50, height: 8)
                .padding(.top, 15)
            
            // Trip info
            HStack(spacing: 15) {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 15)
                    
                    Circle()
                        .fill(Color.theme.backgroundColorBlackToWhite)
                        .frame(width: 6)
                }
                
                VStack(spacing: 14) {
                    
                    HStack {
                        Text("Current location")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemGray2))
                        Spacer()
                        Text(locationSearchViewModel.pickupTime ?? "")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemGray))
                        
                    }
                    
                    HStack {
                        
                        if let location = locationSearchViewModel.selectedTaxiLocation {
                            Text(location.title)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.theme.backgroundColorBlackToWhite)
                        }
                        Spacer()
                        Text(locationSearchViewModel.dropoffTime ?? "")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemGray))
                        
                    }
                }
                .padding(.leading, 8)
            }
            .padding()
            
            // Ride type
            VStack {
                Text("SUGGESTED RIDES")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.darkGray))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 17) {
                        ForEach(RideType.allCases) { type in
                            VStack(alignment: .center) {
                                Image(systemName: type.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 38)
                                    
                                
                                VStack(alignment: .leading) {
                                    Text(type.description)
                                    Text(locationSearchViewModel.computeRidePrice(forType: type).toCurrency())
                                }
                                .font(.caption)
                                .fontWeight(.semibold)
                            }
                            .frame(width: 90, height: 100)
                            .foregroundColor(type == selectedRidyType ? Color.theme.backgroundColorWhiteToBlack : Color.theme.backgroundColorBlackToWhite)
                            .background(type == selectedRidyType ? Color.theme.backgroundColorBlackToWhite : Color(.systemGray6))
                            .scaleEffect(type == selectedRidyType ? 1.1 : 1.0)
                            .cornerRadius(8)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    selectedRidyType = type
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            
            HStack {
                //Payment option
                HStack(spacing: 5) {
                    Text("Visa")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(6)
                        .background(Color.theme.backgroundColorBlackToWhite)
                        .foregroundColor(Color.theme.backgroundColorWhiteToBlack)
                        .cornerRadius(6)
                    
                    HStack(spacing: 1) {
                        Text("****")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.backgroundColorBlackToWhite)
                        
                        Text("1234")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.backgroundColorBlackToWhite)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.trailing, 7)
                
                
                
                
                // Request button
                Button {
                    
                } label: {
                    Text("CONFIRM RIDE")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.theme.backgroundColorWhiteToBlack)
                        .padding(10)
                        .background(Color.theme.backgroundColorBlackToWhite)
                        .cornerRadius(8)
                        
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
        }
        .background(Color.theme.backgroundColorWhiteToBlack)
        .cornerRadius(16)
        .shadow(color: Color(.darkGray), radius: 6)
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
