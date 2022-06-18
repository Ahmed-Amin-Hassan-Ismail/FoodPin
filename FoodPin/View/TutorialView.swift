//
//  TutorialView.swift
//  FoodPin
//
//  Created by Ahmed Amin on 18/06/2022.
//

import SwiftUI

struct TutorialView: View {
    
    //MARK: - Variables
    let pageHeadings = [
        "CREATE YOUR OWN FOOD GUIDE",
        "SHOW YOU THE LOCATION",
        "DISCOVER GREAT RESTAURANTS"
    ]
    let pageSubHeadings = [
        "Pin your favorite restaurants and create your ownfood guide",
        "Search and locate your favorite restaurant on Maps",
        "Find restaurants shared by your friends and other foodies"
    ]
    let pageImages = [
        "onboarding-1",
        "onboarding-2",
        "onboarding-3"
    ]
    
    @State private var currentPage: Int = 0
    @Environment (\.dismiss) var dismiss
    @AppStorage("hasViewedWalkthrough") var hasViewedWalkthrough = false

    
    //MARK: - Init
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .systemIndigo
        UIPageControl.appearance().pageIndicatorTintColor = .lightGray
    }
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(pageHeadings.indices) { index in
                    TutorialPage(
                        image: pageImages[index],
                        heading: pageHeadings[index],
                        subHeading: pageSubHeadings[index])
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .automatic))
            .animation(.default, value: currentPage)
            
            VStack(alignment: .center, spacing: 20) {
                Button {
                    if currentPage < pageHeadings.count - 1 {
                        currentPage += 1
                    } else {
                        hasViewedWalkthrough = true
                        dismiss()
                    }
                } label: {
                    Text(currentPage == pageHeadings.count - 1 ? "GET STARTED" : "NEXT")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 50)
                        .background(Color(.systemIndigo))
                        .cornerRadius(25)
                }
                
                if currentPage < pageHeadings.count - 1 {                    
                    Button {
                        hasViewedWalkthrough = true
                        dismiss()
                    } label: {
                        Text("Skip")
                            .font(.headline)
                            .foregroundColor(Color(.darkGray))
                    }
                }
            }
            .padding(.bottom)
            
        }
        
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
