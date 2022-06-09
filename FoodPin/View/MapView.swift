//
//  MapView.swift
//  FoodPin
//
//  Created by Ahmed Amin on 08/06/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    //MARK: - Variable
    var location: String = ""
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.510357, longitude: -0.116773),
        span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
    
    @State private var annotatedItem = AnnotatedItem(coordinates: CLLocationCoordinate2D(latitude: 51.510357, longitude: -0.116773))
    
    
    var body: some View {
        Map(coordinateRegion: $region, interactionModes: [.all], annotationItems: [annotatedItem]) { item in
            MapMarker(coordinate: item.coordinates, tint: .red)
            
        }
        .task {
            converAddress(address: location)
        }
    }
}

//MARK: - Conver Address
extension MapView {
    private func converAddress(address: String) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address) { placemarks, errors in
            if let error = errors {
                print(error.localizedDescription)
                return
            }
            
            guard let placemarks = placemarks,
                  let location = placemarks[0].location else {
                return
            }
            
            self.region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.0015, longitudeDelta: 0.0015))
            self.annotatedItem = AnnotatedItem(coordinates: location.coordinate)
        }
    }
}

//MARK: - Annotated Item
struct AnnotatedItem: Identifiable {
    let id = UUID()
    var coordinates: CLLocationCoordinate2D
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(location: "54 Frith Street London W1D 4SL United Kingdom")
    }
}


