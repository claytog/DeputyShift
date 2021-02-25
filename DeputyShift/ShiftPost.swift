//
//  ShiftPost.swift
//  DeputyShift
//
//  Created by Clayton on 25/2/21.
//

import Foundation

class ShiftPost: Codable {
    var time: String
    var latitude: String?
    var longitude: String?
    
    init(){
        time = ""
        latitude = "0.00000"
        longitude = "0.00000"
    }
}
