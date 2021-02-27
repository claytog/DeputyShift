//
//  Util.swift
//  DeputyShift
//
//  Created by Clayton on 26/2/21.
//

import Foundation

enum DateType: String {
    case long = "yyyy-MM-dd'T'HH:mm:ssZZZ"
    case medium = "d MMM y hh:mm a"
}

class Util {
    
    static let shared: Util = Util()
    
    func formatDateToString(date: Date, dateType: DateType) -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateType.rawValue

        return formatter.string(from: date)
    }
    
    func formatStringToDate(dateStr: String, dateType: DateType) -> Date?{
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateType.rawValue
        
        guard let date = formatter.date(from: dateStr) else {
            return nil
        }
        
        return date
    }
}
