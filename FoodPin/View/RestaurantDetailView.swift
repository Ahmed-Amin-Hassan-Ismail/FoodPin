//
//  RestaurantDetailView.swift
//  FoodPin
//
//  Created by Ahmed Amin on 05/06/2022.
//

import SwiftUI

struct RestaurantDetailView: View {
    // MARK: - Variables
    var restaurant: Restaurant
    @Environment(\.dismiss) var dismiss
    //@Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .top) {
            Image(restaurant.image)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                .ignoresSafeArea()
            
            Color.black
                .frame(height: 100, alignment: .center)
                .opacity(0.8)
                .cornerRadius(20)
                .padding()
                .overlay(
                    VStack(alignment: .center, spacing: 5) {
                        Text(restaurant.name)
                        Text(restaurant.type)
                        Text(restaurant.location)
                        
                    }
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(.white)
                )
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                   dismiss()
                } label: {
                    Text("\(Image(systemName: "chevron.left")) \(restaurant.name)")
                }

            }
        }
        
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailView(restaurant: Restaurant(name: "Cafe Deadend", type: "Cafe", location: "Hong Kong", image: "cafedeadend", isFavorite: true))
    }
}
