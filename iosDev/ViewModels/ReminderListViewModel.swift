//
//  ReminderListViewModel.swift
//  iosDev
//
//  Created by Isabelle Brian on 16/9/2023.
//
import SwiftUI

class ReminderListViewModel: ObservableObject { // This is my Reminder view model
   @Published var reminders: [ReminderItem] = [] // this array holds all the reminders created by a user
    
    private var userManager: UserManager // calling in user manager to retrieve info such as setby so reminder dislpays who set the reminder with their username
    
    init(userManager: UserManager) { //
        self.userManager = userManager
        fetchReminders()
    }
    
    func fetchReminders() { // function to retrieve reminders , which has listed all the reminderitems aka the components that make a reminder
        let fetchedReminders = self.userManager.fetchReminders() // this is fetched from user manager
        self.reminders = fetchedReminders.map { // fetch request gets processed to the Reminderitem referenced above so it can eb displayed , alos has a default value set
            ReminderItem(id: $0.id ?? UUID(), title: $0.title ?? "", date: $0.date ?? Date(), time: $0.time ?? Date(), setBy: $0.setBy ?? "", desc: $0.desc ?? "")
        }
    }
    
    func deleteReminder(at offsets: IndexSet) { // this function is important, lets users delete a reminder from their list once thei done!
        // Deletes from the core data
 
        reminders.remove(atOffsets: offsets)
    }
    
    
}
