//
//  RestaurantListView.swift
//  FoodPin
//
//  Created by Ahmed Amin on 04/06/2022.
//

import SwiftUI
import CoreData

struct RestaurantListView: View {
    // MARK: - Variables
    @Environment(\.managedObjectContext) var context
    @FetchRequest(
        entity: Restaurant.entity(),
        sortDescriptors: [])
    var restaurants: FetchedResults<Restaurant>
    
    @State private var showNewRestaurant = false
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            List {
                if restaurants.count == 0 {
                    Image("emptydata")
                        .resizable()
                        .scaledToFit()
                } else {
                    ForEach(restaurants.indices, id: \.self) { index in
                        ZStack(alignment: .leading) {
                            NavigationLink(destination: RestaurantDetailView(restaurant: restaurants[index])) {
                                EmptyView()
                            }
                            .opacity(0)
                            
                            BasicTextImageRow(restaurant: restaurants[index])
                        }
                    }
                    .onDelete(perform: deleteRecord)
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            
            .navigationTitle("FoodPin")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                Button(action: {
                    self.showNewRestaurant = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .accentColor(.primary)
        .sheet(isPresented: $showNewRestaurant) {
            NewRestaurantView()
        }
        
    }
}

//MARK: - Helper Methods
extension RestaurantListView {
    
    private func deleteRecord(indexSet: IndexSet) {
        
        for index in indexSet {
            let itemToDelete = restaurants[index]
            context.delete(itemToDelete)
        }

        DispatchQueue.main.async {
            do {
                try context.save()

            } catch {
                print(error)
            }
        }
    }

}

// MARK: - BasicTextImageRow
struct BasicTextImageRow: View {
    @ObservedObject var restaurant: Restaurant
    
    @State private var showOptions: Bool = false
    @State private var showError: Bool = false
    
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            
            if let imageData = restaurant.image {
                Image(uiImage: UIImage(data: imageData) ?? UIImage() )
                    .resizable()
                    .frame(width: 120, height: 120, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            VStack(alignment: .leading, spacing: nil) {
                Text(restaurant.name)
                    .font(.system(.title2, design: .rounded))
                
                Text(restaurant.type)
                    .font(.system(.body, design: .rounded))
                
                Text(restaurant.location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
                
            }
            if restaurant.isFavorite {
                Spacer()
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
            if let imageData = restaurant.image,
               let imageToShare = UIImage(data: imageData) {
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
            if let imageData = restaurant.image {
                Image(uiImage: UIImage(data: imageData) ?? UIImage())
                    .resizable()
                    .frame(width: nil, height: 200, alignment: .center)
                    .scaledToFill()
                    .cornerRadius(20)
            }
            
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
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .preferredColorScheme(.dark)
        //.environment(\.dynamicTypeSize, .xLarge)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            .previewDisplayName("iPhone 11")
    }
}
