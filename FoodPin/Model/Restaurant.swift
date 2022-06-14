//
//  Restaurant.swift
//  FoodPin
//
//  Created by Ahmed Amin on 04/06/2022.
//

import Foundation
import CoreData
import Combine

public class Restaurant: NSManagedObject {
    
    @NSManaged public var name: String
    @NSManaged public var type: String
    @NSManaged public var location: String
    @NSManaged public var phone: String
    @NSManaged public var summary: String
    @NSManaged public var image: Data
    @NSManaged public var isFavorite: Bool
    @NSManaged public var ratingText: String?
    
    init(name: String, type: String, location: String, phone: String, summary: String, image: Data, isFavorite: Bool = false, ratingText: String? = nil) {
        
        self.name = name
        self.type = type
        self.location = location
        self.phone = phone
        self.summary = summary
        self.image = image
        self.isFavorite = isFavorite
        self.ratingText = ratingText
    }
    
    var rating: Rating? {
        get {
            guard let ratingText = ratingText else { return nil }
            return Rating(rawValue: ratingText)
        }
        set {
            self.ratingText = newValue?.rawValue
        }
    }
}
