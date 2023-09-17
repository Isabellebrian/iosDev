//
//  PersistenceController.swift
//  iosDev
//
//  Created by Isabelle Brian on 14/9/2023.
//

import Foundation
import CoreData

class PersistenceController { // class persistence controller
    
    static let shared = PersistenceController() // only one persistence exist and is shared within core data

    let container: NSPersistentContainer // introducing NSP, which is the container that will store information for the persistence controller

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "FamilyScheduler") // The name of the core data file
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null") // since i'm not storing this in-memory i dont need to add a file path
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)") // debugging technique, if there is an error with the persistence controller, it will let me know in the terminal :) 
            }
        })
    }
}
