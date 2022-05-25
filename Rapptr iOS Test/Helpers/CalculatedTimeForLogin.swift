//
//  CalculatedTime.swift
//  Rapptr iOS Test
//
//  Created by Nathan Reilly on 5/16/22.
//

import Foundation

struct CalculatedTimeForLogin {
    let startDate: Date
    var endDate: Date? {
        didSet {
            guard let endDate = endDate else {return}
            CalculatedTimeForLogin.calculatedTimeInterval = endDate.timeIntervalSince(self.startDate)*1000
        }
    }
    static var calculatedTimeInterval: TimeInterval? = nil
    
    init() {
        self.startDate = Date()
        self.endDate = nil
    }
}
