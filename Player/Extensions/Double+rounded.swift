//
//  Double+rounded.swift
//  Player
//
//  Created by Дмитрий Дудкин on 26.06.2021.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
