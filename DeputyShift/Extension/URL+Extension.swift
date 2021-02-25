//
//  URL+Extension.swift
//  DeputyShift
//
//  Created by Clayton on 24/2/21.
//

import Foundation

extension URL {
    
    private static var host = "https://apjoqdqpi3.execute-api.us-west-2.amazonaws.com/dmc/"
    
    static func getShifts() -> URL? {
        
        return URL(string: host + "shifts")
    }
    
    static func postShift(shiftType: ShiftType) -> URL? {
        
        return URL(string: host + "shift/" + shiftType.rawValue)
    }
    
    static func postShiftEnd() -> URL? {
        
        return URL(string: host + "shift/end")
    }
   
}
