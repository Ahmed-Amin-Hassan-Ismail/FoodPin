//
//  TutorialPage.swift
//  FoodPin
//
//  Created by Ahmed Amin on 18/06/2022.
//

import SwiftUI

struct TutorialPage: View {
    let image: String
    let heading: String
    let subHeading: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 70) {
            Image(image)
                .resizable()
                .scaledToFit()
            
            VStack(alignment: .center, spacing: 10) {
                Text(heading)
                    .font(.headline)
                
                Text(subHeading)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
            }
            .padding()
            
            Spacer()
        }
        .padding(.top)
    }
}

struct TutorialPage_Previews: PreviewProvider {
    static var previews: some View {
        TutorialPage(image: "onboarding-1", heading: "CREATE YOUR OWN FOOD GUIDE", subHeading: "Pin your favorite restaurants and create your own food guide")
    }
}
