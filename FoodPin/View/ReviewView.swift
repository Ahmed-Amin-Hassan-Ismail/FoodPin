//
//  ReviewView.swift
//  FoodPin
//
//  Created by Ahmed Amin on 09/06/2022.
//

import SwiftUI

struct ReviewView: View {

    //MARK: - Variables
    var restaurant: Restaurant
    @Binding var isDisplaying: Bool
    @State private var ShowRating: Bool = false
    
    var body: some View {
        ZStack {
            Image(uiImage: UIImage(data: restaurant.image)!)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,
                       maxHeight: .infinity, alignment: .center)
                .background()
                .ignoresSafeArea()
            
            Color.black
                .opacity(0.6)
                .background(.ultraThinMaterial)
                .ignoresSafeArea()
            
            HStack {
                Spacer()
                
                VStack {
                    Button {
                        withAnimation(.easeOut(duration: 2)) {
                            self.isDisplaying = false
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 30.0))
                            .foregroundColor(.white)
                            .padding()
                    }
                    Spacer()
                }
            }
            
            VStack(alignment: .leading ) {
                ForEach(Rating.allCases, id: \.self) { rating in
                    HStack {
                        Image(rating.image)
                        Text(rating.rawValue.capitalized)
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .opacity(ShowRating ? 1.0 : 0.0)
                    .offset(x: ShowRating ? 0 : 1000)
                    .animation(.easeOut.delay(Double(Rating.allCases.firstIndex(of: rating)!) * 0.2), value: ShowRating)
                    .onTapGesture {
                        self.restaurant.rating = rating
                        self.isDisplaying = false
                    }
                }
            }
        }
        .onAppear {
            ShowRating.toggle()
        }
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(restaurant: (PersistenceController.testData?.first)!, isDisplaying: .constant(true))
        }
}
