//
//  RestaurantListView.swift
//  FoodPin
//
//  Created by Ahmed Amin on 04/06/2022.
//

import SwiftUI

struct RestaurantListView: View {
    // MARK: - Variables
    private var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional","Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    private var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkee", "posatelier", "bourkestreetbakery", "haigh", "palomino", "upstate", "traif", "graham", "waffleandwolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "cask"]
    
    private var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
    
    private var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian/ Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee &Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    
    //MARK: - Body
    var body: some View {
        List {
            ForEach(restaurantNames.indices, id: \.self) { index in
                HStack(alignment: .top, spacing: 20) {
                    Image(self.restaurantImages[index])
                        .resizable()
                        .frame(width: 120, height: 120, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    VStack(alignment: .leading, spacing: nil) {
                        Text(self.restaurantNames[index])
                            .font(.system(.title2, design: .rounded))
                        
                        Text(self.restaurantTypes[index])
                            .font(.system(.body, design: .rounded))
                        
                        Text(self.restaurantLocations[index])
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundColor(.gray)
                        
                    }
                }
                
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

//MARK: - Content View
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView()
            .preferredColorScheme(.light)
    }
}
