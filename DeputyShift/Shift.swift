//
//  Shift.swift
//  DeputyShift
//
//  Created by Clayton on 24/2/21.
//

import Foundation

//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

typealias ShiftList = [Shift]

// MARK: - WelcomeElement
class Shift: Codable {
    var id: Int
    var start: String?
    var end: String?
    var startLatitude: String?
    var startLongitude: String?
    var endLatitude: String?
    var endLongitude: String?
    var image: String?

    init(id: Int, start: String?, end: String?, startLatitude: String?, startLongitude: String?, endLatitude: String?, endLongitude: String?, image: String?) {
        self.id = id
        self.start = start
        self.end = end
        self.startLatitude = startLatitude
        self.startLongitude = startLongitude
        self.endLatitude = endLatitude
        self.endLongitude = endLongitude
        self.image = image
    }
}


