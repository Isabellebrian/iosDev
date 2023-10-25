import Foundation
import CoreData // data model holding info regarding the entites 
import SwiftUI

class UserManager: ObservableObject {
    @Published var currentUser: User? // this is the user of the app
    @Published var isAuthenticated: Bool = false // checks to see if the user has logged in using their username + password
    
    let context: NSManagedObjectContext    // declaring constant called context assigned to the NSM
    
    init(context: NSManagedObjectContext) { // init method , set to ask for context as a perimeter 
        self.context = context // clarify the perimeter as let context above
    }
    
    
    // login function, this is the perimeters that are needed from a user for a successful login in. This includes username and password . completion is set to bool type, login is either successful / fail no inbetween
    func login(username: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest() // fetch request from core data to see if any username and password match with within the core data container
        fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        do {
            let users = try context.fetch(fetchRequest)
            if users.count > 0 {
                currentUser = users.first
                completion(true, nil)
            } else {
                completion(false, "Invalid username or password.") // error handling , throw error message at user if the informationd does not match with core data
            }
        } catch { // error handling
            completion(false, "An error occurred while fetching data.")
        }
    }
    
    
    // Register function , takes username, email, password as perimeter . Completed form is either true or false
    func register(username: String, email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        let user = User(context: context)  // refering to context constant above assign to NSM object Context
        user.username = username
        user.email = email
        user.password = password
        do {
            try context.save()
            completion(true, nil)
        } catch { // error handling!
            completion(false, "An error occurred while saving data.")
        }
    }
    
    
    
    //Another function , AddReminder, this is what lets a user add reminders in the app :)
    func addReminder(title: String, time: Date, description: String, date: Date, setBy: String) { // attributes title, time, description , date and setby (as it is a family sharing app)
        // Create a new Reminder instance
        let newReminder = Reminder(context: context)
        newReminder.title = title
        newReminder.time = time
        newReminder.desc = description
        newReminder.date = date
        newReminder.setBy = setBy
        newReminder.id = UUID() // unique id for each reminder row


   
        do {
            try context.save() //saves the reminder within core data, utilises context constant
        } catch {
            print("Failed saving reminder: \(error)") // Another error handling :)
        }
    }
    
    
    
    func fetchReminders() -> [Reminder] { // fetch request , if users added a reminder before and logged in again it will fetch all preivous reminders that have yet been deleted
        let fetchRequest: NSFetchRequest<Reminder> = Reminder.fetchRequest()
        do {
            let fetchedReminders = try context.fetch(fetchRequest)
            return fetchedReminders
        } catch {
            print("Failed to fetch reminders: \(error)") // error handling
            return []
        }
    }
    
    func clearAllReminders() -> Bool { // This is for the clear all button in reminder view, this function clears all reminders from core data and view
        do {
            try context.deleteAllData(forEntityName: "Reminder")
            return true
        } catch {
            print("Failed to delete all reminders: \(error)") // error handling
            return false
        }
    }

}



extension NSManagedObjectContext { // this is an extension of constant context assigned to NSM, this allows us to clear /delete data regarding an entity that we assign 
    func deleteAllData(forEntityName entityName: String) throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        try self.execute(batchDeleteRequest) // runs the delete request!
        try self.save() // saves changes of deleting data
    }
    
}
