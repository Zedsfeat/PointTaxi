//
//  Double.swift
//  PointTaxi
//
//  Created by zedsbook on 05.02.2023.
//

import Foundation

extension Double {
    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func toCurrency() -> String {
        return "$" + (numberFormatter.string(from: self as NSNumber) ?? "0.00")
    }
}
