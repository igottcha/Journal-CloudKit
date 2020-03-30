//
//  Entry.swift
//  CloudKitJournal
//
//  Created by Chris Gottfredson on 3/30/20.
//  Copyright © 2020 Zebadiah Watson. All rights reserved.
//

import CloudKit

struct EntryStrings {
   static let titleKey = "title"
   static let bodykey = "body"
   static let timestampKey = "timestamp"
    static let recordTypeKey = "Entry"
    
}

class Entry {
    
    let title: String
    let body: String
    let timestamp: Date
    
    init(title: String, body: String, timestamp: Date = Date()) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
        
        return
    }
    
}

// Outgoing --> (Hype into CKRecord)
extension CKRecord {
    convenience init(entry: Entry) {
        self.init(recordType: EntryStrings.recordTypeKey)
        self.setValuesForKeys([EntryStrings.titleKey : entry.title, EntryStrings.bodykey : entry.body, EntryStrings.timestampKey : entry.timestamp])
    }
}

// Incoming <-- (CKRecord into Hype)
extension Entry {
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[EntryStrings.titleKey] as? String, let body = ckRecord[EntryStrings.bodykey] as? String, let timestamp = ckRecord[EntryStrings.timestampKey] as? Date else { return nil }
        self.init(title: title, body: body, timestamp: timestamp)
    }
}
