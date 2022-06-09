//
//  Rating.swift
//  FoodPin
//
//  Created by Ahmed Amin on 09/06/2022.
//

import Foundation
import SwiftUI

enum Rating: String, CaseIterable {
    case awesome
    case good
    case okay
    case bad
    case terrible
    
    var image: String {
        switch self {
        case .awesome:
            return "love"
        case .good:
            return "cool"
        case .okay:
            return "happy"
        case .bad:
            return "sad"
        case .terrible:
            return "angry"
        }
    }
}
