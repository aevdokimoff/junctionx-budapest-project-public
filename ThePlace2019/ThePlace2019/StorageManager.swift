//
//  StorageManager.swift
//  ThePlace2019
//
//  Created by Михаил Луцкий on 27.10.2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    
    var pinStructure = FilterS(emoji: "🏢", title: "Resedence", json: "")
}
