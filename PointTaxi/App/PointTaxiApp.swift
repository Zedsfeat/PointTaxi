//
//  PointTaxiApp.swift
//  PointTaxi
//
//  Created by zedsbook on 24.01.2023.
//

import SwiftUI

@main
struct PointTaxiApp: App {
    @StateObject var locationSearchViewModel = LocationSearchViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationSearchViewModel)
        }
    }
}
