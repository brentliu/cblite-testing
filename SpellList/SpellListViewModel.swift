//
//  SpellListViewModel.swift
//  SpellList
//
//  Created by Brent Liu on 6/22/21.
//

import Foundation
import CouchbaseLiteSwift

class SpellListViewModel: ObservableObject {
    var spells: [Spell] = []
    
    private var database: Database
    
    init () {
        
        do {
            database = try Database(name: "mydb")
        } catch {
            fatalError("Error opening database")
        }
        
        
        
        testDatabase()
        populateSpells()
        
        let sampleSpell = spells.first!
        
        print(sampleSpell.id)
        
        let encoder = JSONEncoder()
        var sampleJSON: Data
        do {
            sampleJSON = try encoder.encode(sampleSpell)
            let json = try JSONSerialization.jsonObject(with: sampleJSON, options: [])
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    // print(object)
                    let sampleSpellStringDict = object
                    let doc = MutableDocument(data: sampleSpellStringDict)
                } else if let object = json as? [Any] {
                    // json is an array
                    print(object)
                } else {
                    print("JSON is invalid")
                }
            
        } catch {
            print("error with test code for sample spell to mutable doc", error)
        }
        
        let query = QueryBuilder
            .select(SelectResult.all())
            .from(DataSource.database(database))
        
        do {
            var resultSet = try query.execute()
            print("1st call", resultSet.allResults())
            print("2nd call", resultSet.allResults())
        
        } catch {
            print(error)
        }
    }
    
    func testDatabase() {
        // Get the database (and create it if it doesn’t exist).

        // Create a new document (i.e. a record) in the database.
        let mutableDoc = MutableDocument()
            .setFloat(2.0, forKey: "version")
            .setString("SDK", forKey: "type")

        // Save it to the database.
        do {
            try database.saveDocument(mutableDoc)
        } catch {
            fatalError("Error saving document")
        }

        // Update a document.
        if let mutableDoc = database.document(withID: mutableDoc.id)?.toMutable() {
            mutableDoc.setString("Swift", forKey: "language")
            do {
                try database.saveDocument(mutableDoc)
                
                let document = database.document(withID: mutableDoc.id)!
                // Log the document ID (generated by the database)
                // and properties
                print("Document ID :: \(document.id)")
                print("Learning \(document.string(forKey: "language")!)")
            } catch {
                fatalError("Error updating document")
            }
        }

        // Create a query to fetch documents of type SDK.
        let query = QueryBuilder
            .select(SelectResult.all())
            .from(DataSource.database(database))
            .where(Expression.property("type").equalTo(Expression.string("SDK")))

        // Run the query.
        do {
            let result = try query.execute()
            print("Number of rows :: \(result.allResults().count)")
        } catch {
            fatalError("Error running the query")
        }
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func parse(jsonData: Data) -> [Spell]? {
        do {
            let decodedData = try JSONDecoder().decode([Spell].self,
                                                       from: jsonData)
            return decodedData
        } catch {
            print("decode error")
            print(error)
        }
        return nil
    }
    
    func populateSpells () {
        let data = readLocalFile(forName: "spells")
        if let data = data {
            spells = parse(jsonData: data)!
        } else {
            print("data was nil")
        }
    }
}
