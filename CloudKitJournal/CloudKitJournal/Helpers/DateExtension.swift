//
//  DateExtension.swift
//  CloudKitJournal
//
//  Created by Chris Gottfredson on 3/30/20.
//  Copyright © 2020 Zebadiah Watson. All rights reserved.
//

import Foundation

extension Date {
    //formats a date into a string using dateStyle.short and timeStyle.short
    
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
}
