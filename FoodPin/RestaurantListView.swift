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
    
    @State private var restaurantIsFavorites = Array(repeating: false, count: 21)
    
    
    //MARK: - Body
    var body: some View {
        List {
            ForEach(restaurantNames.indices, id: \.self) { index in
                //BasicTextImageRow(restaurantImage: restaurantImages[index], restaurantName: restaurantNames[index], restaurantType: restaurantTypes[index], restaurantLocation: restaurantLocations[index], isFavorite: $restaurantIsFavorites[index] )
                
                FullImageRow(restaurantImage: restaurantImages[index], restaurantName: restaurantNames[index], restaurantType: restaurantTypes[index], restaurantLocation: restaurantLocations[index], isFavorite: $restaurantIsFavorites[index])
                
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

// MARK: - BasicTextImageRow
struct BasicTextImageRow: View {
    var restaurantImage: String
    var restaurantName: String
    var restaurantType: String
    var restaurantLocation: String
    @Binding var isFavorite: Bool
    
    @State private var showOptions: Bool = false
    @State private var showError: Bool = false
    
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(restaurantImage)
                .resizable()
                .frame(width: 120, height: 120, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(alignment: .leading, spacing: nil) {
                Text(restaurantName)
                    .font(.system(.title2, design: .rounded))
                
                Text(restaurantType)
                    .font(.system(.body, design: .rounded))
                
                Text(restaurantLocation)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
                
            }
            Spacer()
            if isFavorite {
                Image(systemName: "heart.fill")
                    .foregroundColor(.yellow)
            }
        }
        .onTapGesture {
            self.showOptions.toggle()
        }
        
        .actionSheet(isPresented: $showOptions) {
            ActionSheet(title: Text("What do you want to do?"),
                        message: nil,
                        buttons: [
                            .default(Text("Reserve Table"), action: {
                                self.showError.toggle()
                            }),
                            .default(Text("Mark as favorite"), action: {
                                self.isFavorite.toggle()
                            }),
                            .cancel()
                        ])
        }
        .alert(isPresented: $showError) {
            Alert(title: Text("Not yet available"),
                  message: Text("sorry, this feature is not available yet, please retry later."),
                  primaryButton: .default(Text("Ok")),
                  secondaryButton: .cancel())
        }
    }
}

//MARK: - FullImageRow
struct FullImageRow: View {
    var restaurantImage: String
    var restaurantName: String
    var restaurantType: String
    var restaurantLocation: String
    @Binding var isFavorite: Bool
    
    @State private var showOptions: Bool = false
    @State private var showError: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(restaurantImage)
                .resizable()
                .frame(width: nil, height: 200, alignment: .center)
                .scaledToFill()
                .cornerRadius(20)
            
            HStack(alignment: .top, spacing: nil) {
                VStack(alignment: .leading, spacing: nil) {
                    Text(restaurantName)
                        .font(.system(.title2, design: .rounded))
                    
                    Text(restaurantType)
                        .font(.system(.body, design: .rounded))
                    
                    Text(restaurantLocation)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                Spacer()
                
                if isFavorite {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.yellow)
                }
            }
            
        }
        .onTapGesture {
            self.showOptions.toggle()
        }
        .actionSheet(isPresented: $showOptions) {
            ActionSheet(title: Text("What do you want to do?"),
                        message: nil,
                        buttons: [
                            .default(Text("Reserve Table"), action: {
                                showError.toggle()
                            }),
                            .default(isFavorite ? Text("Remove from favorites") : Text("Mark as favorite") , action: {
                                isFavorite.toggle()
                            }),
                            .cancel()
                        ])
        }
        .alert(isPresented: $showError) {
            Alert(title: Text("Not Yet Available")
                  , message: Text("Sorry, this feature is not available yet, please retry later."),
                  primaryButton: .default(Text("Ok")),
                  secondaryButton: .cancel())
        }
    }
}



//MARK: - Content View
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView()
            .preferredColorScheme(.dark)
    }
}
