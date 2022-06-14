//
//  Persistence.swift
//  FoodPin
//
//  Created by Ahmed Amin on 14/06/2022.
//

import Foundation
import CoreData
import UIKit


struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "FoodPin")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error as? NSError {
                fatalError("Unresolved error \(error)")
            }
            
        }
    }
}
