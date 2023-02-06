//
//  LocationSearchActivationView.swift
//  PointTaxi
//
//  Created by zedsbook on 26.01.2023.
//

import SwiftUI

struct LocationSearchActivationView: View {
    var body: some View {
        HStack(spacing: 0) {
            Circle()
                .fill(.black)
                .frame(width: 10)
                .padding(.horizontal)
            
            Text("Where to?")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(Color(.darkGray))
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64, height: 45)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(color: Color(.darkGray), radius: 6)
        )
    }
}

struct LocationSearchActivationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchActivationView()
    }
}
