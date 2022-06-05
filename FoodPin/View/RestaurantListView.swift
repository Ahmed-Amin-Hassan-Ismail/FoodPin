//
//  RestaurantListView.swift
//  FoodPin
//
//  Created by Ahmed Amin on 04/06/2022.
//

import SwiftUI

struct RestaurantListView: View {
    // MARK: - Variables
    @State var restaurants = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", image: "cafedeadend", isFavorite: false),
        Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image:
    "homei", isFavorite: false),
        Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha", isFavorite: false),
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", image: "cafeloisl", isFavorite: false),
    Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong", image: "petiteoyster", isFavorite: false),
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", image: "forkee", isFavorite: false),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong"
    , image: "posatelier", isFavorite: false),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney", image: "bourkestreetbakery", isFavorite: false),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", image: "haigh", isFavorite: false),
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", image: "palomino", isFavorite: false),
        Restaurant(name: "Upstate", type: "American", location: "New York", image: "upstate", isFavorite: false),
        Restaurant(name: "Traif", type: "American", location: "New York", image: "traif", isFavorite: false),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "graham", isFavorite: false),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "NewYork", image: "waffleandwolf", isFavorite: false),
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", image: "fiveleaves", isFavorite: false),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", image: "cafelore", isFavorite: false),
        Restaurant(name: "Confessional", type: "Spanish", location: "New York", image: "confessional", isFavorite: false),
        Restaurant(name: "Barrafina", type: "Spanish", location: "London", image: "barrafina", isFavorite: false),
        Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "donostia", isFavorite: false),
        Restaurant(name: "Royal Oak", type: "British", location: "London", image: "royaloak", isFavorite: false),
        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", image: "cask", isFavorite: false)
    ]
    
    
    //MARK: - Body
    var body: some View {
        List {
            ForEach(restaurants.indices, id: \.self) { index in
                BasicTextImageRow(restaurant: $restaurants[index])
                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        Button {
                            
                        } label: {
                            Image(systemName: "heart")
                        }
                        .tint(Color.green)
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                        }
                        .tint(Color.orange)


                    }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

// MARK: - BasicTextImageRow
struct BasicTextImageRow: View {
    @Binding var restaurant: Restaurant
    
    @State private var showOptions: Bool = false
    @State private var showError: Bool = false
    
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(restaurant.image)
                .resizable()
                .frame(width: 120, height: 120, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(alignment: .leading, spacing: nil) {
                Text(restaurant.name)
                    .font(.system(.title2, design: .rounded))
                
                Text(restaurant.type)
                    .font(.system(.body, design: .rounded))
                
                Text(restaurant.location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
                
            }
            Spacer()
            if restaurant.isFavorite {
                Image(systemName: "heart.fill")
                    .foregroundColor(.yellow)
            }
        }
        .contextMenu {
            Button {
                self.showError.toggle()
            } label: {
                HStack {
                    Text("Reverse a table")
                    Image(systemName: "phone")
                }
            }
            
            Button {
                self.restaurant.isFavorite.toggle()
            } label: {
                HStack {
                    Text(restaurant.isFavorite ? "Remove from favorites" : "Mark as a favorite")
                    Image(systemName: "heart")
                }
            }
            
            Button {
                self.showOptions.toggle()
            } label: {
                HStack {
                    Text("Share")
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
        .alert(isPresented: $showError) {
            Alert(title: Text("Not yet available"),
                  message: Text("sorry, this feature is not available yet, please retry later."),
                  primaryButton: .default(Text("Ok")),
                  secondaryButton: .cancel())
        }
        .sheet(isPresented: $showOptions) {
            let defaultText = "Just checking in at \(restaurant.name)"
            if let imageToShare = UIImage(named: restaurant.image) {
                ActivityView(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else {
                ActivityView(activityItems: [defaultText], applicationActivities: nil)
            }
        }
    }
}

//MARK: - FullImageRow
struct FullImageRow: View {
    @Binding var restaurant: Restaurant
    
    @State private var showOptions: Bool = false
    @State private var showError: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(restaurant.image)
                .resizable()
                .frame(width: nil, height: 200, alignment: .center)
                .scaledToFill()
                .cornerRadius(20)
            
            HStack(alignment: .top, spacing: nil) {
                VStack(alignment: .leading, spacing: nil) {
                    Text(restaurant.name)
                        .font(.system(.title2, design: .rounded))
                    
                    Text(restaurant.type)
                        .font(.system(.body, design: .rounded))
                    
                    Text(restaurant.location)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                Spacer()
                
                if restaurant.isFavorite {
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
                            .default(restaurant.isFavorite ? Text("Remove from favorites") : Text("Mark as favorite") , action: {
                                restaurant.isFavorite.toggle()
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
            .preferredColorScheme(.light)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            .previewDisplayName("iPhone 11")
    }
}
