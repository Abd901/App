//
//  Item.swift
//  App
//
//  Created by Abdul Kadir Öci on 09.02.24.
//

import Foundation
import SwiftData

@Model
 class Item {
    var id :String?
    var timestamp:Date
    var name:String
    
     init(name:String) {
        self.id = UUID().uuidString
        self.timestamp =  Date()
        self.name = name
    }
}
