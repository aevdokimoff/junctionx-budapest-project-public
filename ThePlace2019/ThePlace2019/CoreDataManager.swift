//
//  CoreDataManager.swift
//  ThePlace2019
//
//  Created by Михаил Луцкий on 27.10.2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import MagicalRecord

class CoreDataManager: NSObject {
    
    class func addToFav(emoji: String, title: String, address: String) {
        let fav = Fav.mr_createEntity()
        fav?.emoji = emoji
        fav?.address = address
        fav?.title = title
        NSManagedObjectContext.mr_default().mr_saveToPersistentStore(completion: { (_, _) -> Void in
        })
    }
    
    class func getAllFav() -> [Fav] {
        return Fav.mr_findAll() as! [Fav]
    }
}
