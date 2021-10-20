//
//  Date.swift
//  SoftUni-L8
//
//  Created by Martin Kuvandzhiev on 20.10.21.
//

import Foundation


extension Date {
    var dateInISO8601: String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullTime,
                                       .withTimeZone,
                                       .withFullDate,
                                       .withDashSeparatorInDate,
                                       .withFractionalSeconds]
        
        return dateFormatter.string(from: self)
    }
}
