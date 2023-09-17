import Foundation
import CoreData
import SwiftUI

class UserManager: ObservableObject {
    @Published var currentUser: User?
    @Published var isAuthenticated: Bool = false
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func login(username: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        do {
            let users = try context.fetch(fetchRequest)
            if users.count > 0 {
                currentUser = users.first
                completion(true, nil)
            } else {
                completion(false, "Invalid username or password.")
            }
        } catch {
            completion(false, "An error occurred while fetching data.")
        }
    }
    
    func register(username: String, email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        let user = User(context: context)
        user.username = username
        user.email = email
        user.password = password
        do {
            try context.save()
            completion(true, nil)
        } catch {
            completion(false, "An error occurred while saving data.")
        }
    }
    
    func addReminder(title: String, time: Date, description: String, date: Date, setBy: String) {
        // Create a new Reminder instance
        let newReminder = Reminder(context: context)
        newReminder.title = title
        newReminder.time = time
        newReminder.desc = description  //
        newReminder.date = date
        newReminder.setBy = setBy
        newReminder.id = UUID() //


        // Save the reminder
        do {
            try context.save()
        } catch {
            print("Failed saving reminder: \(error)")
        }
    }
    
    func fetchReminders() -> [Reminder] {
        let fetchRequest: NSFetchRequest<Reminder> = Reminder.fetchRequest()
        do {
            let fetchedReminders = try context.fetch(fetchRequest)
            return fetchedReminders
        } catch {
            print("Failed to fetch reminders: \(error)")
            return []
        }
    }
    
    func clearAllReminders() -> Bool {
        do {
            try context.deleteAllData(forEntityName: "Reminder")
            return true
        } catch {
            print("Failed to delete all reminders: \(error)")
            return false
        }
    }

}



extension NSManagedObjectContext {
    func deleteAllData(forEntityName entityName: String) throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        try self.execute(batchDeleteRequest)
        try self.save()
    }
}
