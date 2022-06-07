//
//  FoodPinApp.swift
//  FoodPin
//
//  Created by Ahmed Amin on 04/06/2022.
//

import SwiftUI

@main
struct FoodPinApp: App {
    init() {
        let navigationBarAppearance = UINavigationBarAppearance()
        
        navigationBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(named: "NavigationBarTitle")!,
            .font: UIFont(name: "ArialRoundedMTBold", size: 35)!
        ]
        
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor(named: "NavigationBarTitle")!,
            .font: UIFont(name: "ArialRoundedMTBold", size: 20)!
        ]
        
        navigationBarAppearance.backgroundColor = .clear
        navigationBarAppearance.backgroundEffect = .none
        navigationBarAppearance.shadowColor = .clear
        
        //UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        //UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        
    }
    var body: some Scene {
        WindowGroup {
            RestaurantListView()
                .preferredColorScheme(.dark)
        }
    }
}
