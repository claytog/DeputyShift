//
//  URL+Extension.swift
//  DeputyShift
//
//  Created by Clayton on 24/2/21.
//

import Foundation

extension URL {
    
    static func getShifts() -> URL? {
        
        return URL(string: "https://apjoqdqpi3.execute-api.us-west-2.amazonaws.com/dmc/shifts")
    }
    
//    static func forMoviesByImdbId(_ imdbId: String) -> URL? {
//        return URL(string: "http://www.omdbapi.com/?i=\(imdbId)&apikey=\(Constants.API_KEY)")
//    }
   
}
