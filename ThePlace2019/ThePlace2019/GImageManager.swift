//
//  GImageManager.swift
//  ThePlace2019
//
//  Created by Михаил Луцкий on 26.10.2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation

class GImageManager {
    
    var latitude = 0.0
    var longitude = 0.0
    
    init (latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func makeString() -> String {
        let str = "https://maps.googleapis.com/maps/api/streetview?location=\(latitude),\(longitude)&key=AIzaSyDxyMUp-nPA6C5M7lFydWSyHwCDAM5zYYE&size=600x400"
        return str
    }
    
    func makeMapImageLink() -> String {
        let str = "https://maps.googleapis.com/maps/api/staticmap?center=\(latitude),\(longitude)&zoom=14&size=400x400&key=AIzaSyDqCWYrOQMfTTEEhOXpU_v5ozFS_di--24"
        return str
    }
    
}
