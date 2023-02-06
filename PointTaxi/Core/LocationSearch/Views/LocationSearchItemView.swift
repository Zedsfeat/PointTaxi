//
//  LocationSearchItemView.swift
//  PointTaxi
//
//  Created by zedsbook on 01.02.2023.
//

import SwiftUI

struct LocationSearchItemView: View {
    
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "mappin.square.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40)
                .foregroundColor(Color.theme.backgroundColorBlackToWhite)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.body)
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.7)
                
                Text(subtitle)
                    .lineLimit(2)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .minimumScaleFactor(0.7)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 6)
    }
}

struct LocationSearchItemView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchItemView(title: "", subtitle: "")
    }
}
