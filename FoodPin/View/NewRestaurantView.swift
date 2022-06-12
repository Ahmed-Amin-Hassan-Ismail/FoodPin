//
//  NewRestaurantView.swift
//  FoodPin
//
//  Created by Ahmed Amin on 12/06/2022.
//

import SwiftUI

struct NewRestaurantView: View {
    @State private var restaurantName: String = ""
    var body: some View {
        
        NavigationView {
            ScrollView {
                
                VStack {
                    FormTextField(label: "Name",
                                  placeHolder: "Fill in the restaurant name",
                                  value: .constant(""))
                    
                    FormTextField(label: "Type",
                                  placeHolder: "Fill in the restaurant type",
                                  value: .constant(""))
                    
                    FormTextField(label: "Address",
                                  placeHolder: "Fill in the restaurant address",
                                  value: .constant(""))
                    
                    FormTextField(label: "Phone",
                                  placeHolder: "Fill in the restaurant phone",
                                  value: .constant(""))
                    
                    FormTextView(label: "Description", value: .constant(""))
                }
                .padding()
            }
            .navigationTitle("New Restaurant")
        }
    }
}

//MARK: - FormTextField
struct FormTextField: View {
    let label: String
    let placeHolder: String
    @Binding var value: String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: nil) {
            Text(label.uppercased())
                .font(.system(.headline, design: .rounded))
                .foregroundColor(Color(.darkGray))
            
            TextField(placeHolder, text: $value)
                .font(.system(.body, design: .rounded))
                .textFieldStyle(PlainTextFieldStyle())
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(.systemGray5), lineWidth: 1)
                )
                .padding(.vertical, 10)
        }
        
    }
}

//MARK: - FormTextView
struct FormTextView: View {
    let label: String
    let height: CGFloat = 200.0
    @Binding var value: String
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil) {
            Text(label.uppercased())
                .font(.system(.headline, design: .rounded))
                .foregroundColor(Color(.darkGray))
            
            TextEditor(text: $value)
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: height, alignment: .center)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(.systemGray5), lineWidth: 1)
                )
                .padding(.top, 10)
            
        }
        
    }
}

struct NewRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        NewRestaurantView()
//        FormTextField(label: "NAME", placeHolder: "Fill in the restaurant name", value: .constant(""))
//            .previewLayout(.fixed(width: 300, height: 200))
//        FormTextView(label: "Description", value: .constant(""))
//            .previewLayout(.sizeThatFits)
    }
}
