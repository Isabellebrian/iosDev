//
//  ReminderListViewModel.swift
//  iosDev
//
//  Created by Isabelle Brian on 16/9/2023.
//
import SwiftUI

class ReminderListViewModel: ObservableObject {
    // Published properties to be observed by the View
   @Published var reminders: [ReminderItem] = []
    
    private var userManager: UserManager
    
    init(userManager: UserManager) {
        self.userManager = userManager
        fetchReminders()
    }
    
    func fetchReminders() {
        let fetchedReminders = self.userManager.fetchReminders()
        self.reminders = fetchedReminders.map {
            ReminderItem(id: $0.id ?? UUID(), title: $0.title ?? "", date: $0.date ?? Date(), time: $0.time ?? Date(), setBy: $0.setBy ?? "", desc: $0.desc ?? "")
        }
    }
    
    func deleteReminder(at offsets: IndexSet) {
        // Delete from your core data or other source first
        // ...
        // Then, update the local reminders array
        reminders.remove(atOffsets: offsets)
    }
    
    
}
