import Foundation
import CoreData
import SwiftUI

class UserManager: ObservableObject {
    @Published var currentUser: User?
    
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
}
