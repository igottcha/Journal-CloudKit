//
//  EntryError.swift
//  CloudKitJournal
//
//  Created by Chris Gottfredson on 3/30/20.
//  Copyright © 2020 Zebadiah Watson. All rights reserved.
//

import Foundation

enum EntryError: LocalizedError {
    
    case thrown(Error)
    case noData
    
    var errorDescription: String? {
        switch self {
            case .thrown(let error):
                return error.localizedDescription
            case .noData:
                return "Server responded with no data"
        }
    }
}
