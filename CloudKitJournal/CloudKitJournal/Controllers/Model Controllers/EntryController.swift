//
//  EntryController.swift
//  CloudKitJournal
//
//  Created by Chris Gottfredson on 3/30/20.
//  Copyright © 2020 Zebadiah Watson. All rights reserved.
//

import CloudKit

class EntryController {
    
    //MARK: - Shared Instance and Source of Truth
    static let shared = EntryController()
    var entries: [Entry] = []
    let privateDB = CKContainer.default().privateCloudDatabase
    
    func createEntry(title: String, body: String, completion: @escaping (Result<Entry, EntryError>) -> Void) {
        
        let entry = Entry(title: title, body: body)
        let entryRecord = CKRecord(entry: entry)
        
        privateDB.save(entryRecord) { (record, error) in
            if let error = error {
                print(error.localizedDescription + " --> \(error)")
                completion(.failure(.thrown(error)))
            }
            guard let record = record, let entry = Entry(ckRecord: record) else { return completion(.failure(.noData)) }
            self.entries.insert(entry, at: 0)
            completion(.success(entry))
        }
    }
    
    func fetchEntries(completion: @escaping (Result<[Entry], EntryError>) -> Void) {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: EntryStrings.recordTypeKey, predicate: predicate)
        
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription + " --> \(error)")
                completion(.failure(.thrown(error)))
            }
            
            guard let records = records else { return completion(.failure(.noData))}
            let entries: [Entry] = records.compactMap(Entry.init(ckRecord: ))
            self.entries = entries
            completion(.success(entries))
        }
        
    }
}
