//
//  NewRestaurantView.swift
//  FoodPin
//
//  Created by Ahmed Amin on 12/06/2022.
//

import SwiftUI

struct NewRestaurantView: View {
    
    enum PhotoSource: Identifiable {
        case photoLibrary
        case camera
        
        var id: Int {
            hashValue
        }
    }
    
    @State private var restaurantName: String = ""
    @State private var restaurantImage = UIImage(named: "newphoto")!
    @State private var showOphotoOptions: Bool = false
    @State private var photoSource: PhotoSource?
    @Environment (\.dismiss) var dismiss
    
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                VStack {
                    Image(uiImage: restaurantImage)
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        .frame(height: 200, alignment: .center)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.bottom)
                        .onTapGesture {
                            self.showOphotoOptions.toggle()
                        }
                    
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
                    
                    FormTextView(label: "Description", height: 100.0, value: .constant(""))
                }
                .padding()
            }
            .actionSheet(isPresented: $showOphotoOptions, content: {
                ActionSheet(title: Text("Choose your photo source"),
                            message: nil,
                            buttons: [
                                .default(Text("Camera"), action: {
                                    self.photoSource = .camera
                                }),
                                .default(Text("Photo Library"), action: {
                                    self.photoSource = .photoLibrary
                                }),
                                .cancel()
                            ])
            })
            .fullScreenCover(item: $photoSource, content: { source in
                switch source {
                case .camera:
                    ImagePicker(sourceType: .camera, selectedImage: $restaurantImage)
                        .ignoresSafeArea()
                    
                case .photoLibrary:
                    ImagePicker(sourceType: .photoLibrary, selectedImage: $restaurantImage)
                        .ignoresSafeArea()
                    
                }
            })
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .accentColor(.primary)
                        
                    }

                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.dismiss()
                    } label: {
                        Text("Save")
                            .font(.headline)
                            .foregroundColor(Color("NavigationBarTitle"))
                    }

                }
            })
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
                .foregroundColor(.primary)
            
            TextField(placeHolder, text: $value)
                .font(.system(.body, design: .rounded))
                .textFieldStyle(PlainTextFieldStyle())
                .foregroundColor(.primary)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.secondary, lineWidth: 1)
                )
                .padding(.vertical, 10)
        }
        
    }
}

//MARK: - FormTextView
struct FormTextView: View {
    let label: String
    let height: CGFloat
    @Binding var value: String
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil) {
            Text(label.uppercased())
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.primary)
            
            TextEditor(text: $value)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: height, alignment: .center)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.secondary, lineWidth: 1)
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
