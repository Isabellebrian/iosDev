//
//  UserManager.swift
//  iosDev
//
//  Created by Isabelle Brian on 14/9/2023.
//

//  UserManager.swift
//  iosDev
//
//  Created by Isabelle Brian on 14/9/2023.
//

import Foundation
import SwiftUI
import CoreData

class UserManager: ObservableObject {
    @Published var currentUser: User?
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func login(username: String, email: String) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@ AND email == %@", username, email)

        do {
            let results = try context.fetch(fetchRequest)
            if let foundUser = results.first {
                self.currentUser = foundUser
            } else {
                print("No user found with provided credentials.")
            }
        } catch {
            print("Error fetching user: \(error)")
        }
    }
    
    func register(username: String, email: String) {
        let newUser = User(context: context)
        newUser.username = username
        newUser.email = email

        do {
            try context.save()
            self.currentUser = newUser
        } catch {
            print("Error saving new user: \(error)")
        }
    }
}
