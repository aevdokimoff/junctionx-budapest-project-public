//
//  VisionModel.swift
//  ThePlace2019
//
//  Created by Михаил Луцкий on 27.10.2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class VisionModel: Mappable {
    
    var description: String!
    var mid: String!
    var score: String!
    var topicality: String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        description <- map["description"]
        mid <- map["mid"]
        score <- map["score"]
        topicality <- map["topicality"]
    }
    
}

class PointModel: Mappable {
    var name: String!
    var value: ValueModel!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        value <- map["value"]
    }
}

class ValueModel: Mappable {
    var animals_ground: String!
    var animals_sky: String!
    var animals_water: String!
    var coordinates: CoordsModel!
    var restrictions_ground: String!
    var restrictions_sky: String!
    var restrictions_water: String!
    var to_build_here: [BuildModel]!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        animals_ground <- map["animals_ground"]
        animals_sky <- map["animals_sky"]
        animals_water <- map["animals_water"]
        coordinates <- map["coordinates"]
        restrictions_ground <- map["restrictions_ground"]
        restrictions_sky <- map["restrictions_sky"]
        restrictions_water <- map["restrictions_water"]
        to_build_here <- map["to_build_here"]
    }
}

class CoordsModel: Mappable {
    var lat: Double!
    var lng: Double!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        lat <- map["lat"]
        lng <- map["long"]
    }
}

class BuildModel: Mappable {
    var name: String!
    var value: Double!
    var img: String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        value <- map["value"]
        img <- map["img"]
    }
}
