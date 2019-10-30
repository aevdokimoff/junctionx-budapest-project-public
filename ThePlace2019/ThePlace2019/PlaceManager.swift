//
//  PlaceManager.swift
//  ThePlace2019
//
//  Created by Михаил Луцкий on 26.10.2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import GooglePlaces

protocol PlaceManagerDelegate: NSObject {
    func didFinishWithResults()
}

struct Place {
    var placeId: String
    var address: String
}

class PlaceManager {
    
    weak var delegate: PlaceManagerDelegate?
    
    let filter = GMSAutocompleteFilter()
    let placesClient = GMSPlacesClient.shared()
    
    var places = [Place]()
    
    init() {
        filter.country = "HU"
        filter.type = GMSPlacesAutocompleteTypeFilter.address
    }
    
    func getAddressesForText(_ text: String, success: @escaping(_ places: [Place]) -> Void) {
        placesClient.autocompleteQuery(text, bounds: nil, filter: filter, callback: {(results, error) in
            if let error = error {
                print("Autocomplete error \(error)")
            }
            self.places.removeAll()
            if let results = results {
                for result in results {
                    let place = Place(placeId: result.placeID, address: result.attributedFullText.string)
                    self.places.append(place)
                    print(result.types)
                }
            }
            success(self.places)
        })
    }
    
    func getCoordsOfPlaceId(_ id: String, success: @escaping(_ coordinates: CLLocationCoordinate2D) -> Void) {
        placesClient.lookUpPlaceID(id, callback: {(place,error) in
            if let error = error {
                print(error)
            }
            
            if let place = place {
                success(place.coordinate)
            }
        })
    }
}
