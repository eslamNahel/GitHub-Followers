//
//  Date+Ext.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 13/01/2022.
//

import Foundation


extension Date {
    
    func convertToString() -> String {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
