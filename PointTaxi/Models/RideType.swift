//
//  RideType.swift
//  Navigator
//
//  Created by zedsbook on 05.02.2023.
//

import Foundation

enum RideType: Int, CaseIterable, Identifiable {
    var id: Int { return rawValue}
    
    case economy
    case comfort
    case business
    case minibus
    case premium
    
    var description: String {
        switch self {
        case .economy: return "Economy"
        case .comfort: return "Comfort"
        case .business: return "Business"
        case .minibus: return "Minibus"
        case .premium: return "Premium"
        }
    }
    
    var imageName: String {
        switch self {
        case .economy: return "car"
        case .comfort: return "car.rear"
        case .business: return "car.fill"
        case .minibus: return "bus.fill"
        case .premium: return "car.rear.fill"
        }
    }
    
    private var baseFare: Double {
        switch self {
        case .economy: return 5
        case .comfort: return 7.5
        case .business: return 10
        case .minibus: return 12.5
        case .premium: return 15
        }
    }
    
    func computePrice(for distanceInMeters: Double) -> Double {
        let distanceInMiles = distanceInMeters / 1600
        switch self {
        case .economy: return distanceInMiles * 1.5 + baseFare
        case .comfort: return distanceInMiles * 2.0 + baseFare
        case .business: return distanceInMiles * 2.5 + baseFare
        case .minibus: return distanceInMiles * 3.0 + baseFare
        case .premium: return distanceInMiles * 3.5 + baseFare
        }
    }
}
