//
//  TextHelper.swift
//  CitySights App
//
//  Created by Jonathan Guerrero on 6/29/25.
//

import Foundation

struct TextHelper {
    
    static func distanceAwayText(meters: Double) -> String {
        
        if meters > 1000 {
            return "\(Int(round(meters/1000))) km away"
        }
        else {
            return "\(Int(round(meters))) m away"
        }
    }
    static func roundToHalf(_ value: Double) -> Double {
        return (value * 2).rounded(.toNearestOrAwayFromZero) / 2
    }
    
}
