//
//  String+Ext.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 13/01/2022.
//

import Foundation


extension String {
    
    func convertToData() -> Date? {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale        = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone      = .current
        
        return dateFormatter.date(from: self)
    }
    
    
    func convertToUIFormat() -> String {
        guard let date = self.convertToData() else {
            return "N/A"
        }
        
        return date.convertToString()
    }
}
