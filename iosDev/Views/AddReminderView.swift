//
//  AddReminderView.swift
//  iosDev
//
//  Created by Isabelle Brian on 16/9/2023.
//
import SwiftUI

struct AddReminderView: View {  // This is the AddReminder sheet!
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userManager: UserManager


    @State private var title: String = ""
    @State private var time: Date = Date()
    @State private var desc: String = ""
    @State private var date: Date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) { //This is the form that will appear for users, where there are textfields and a category selector with pre-defined subcategories to chose from.
                    TextField("Title", text: $title)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    DatePicker("Time", selection: $time, displayedComponents: .hourAndMinute)
                    TextField("Description", text: $desc)
                }
                
                Button(action: saveReminder) { // button to save the reminder
                    Text("Save Reminder")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .navigationBarTitle("Add Reminder", displayMode: .inline) // modifier  added here to add a sheet title
            .navigationBarItems(
                leading: Button(action: { // This is important, allows users to exit the sheet if they change their mind and do not want to add a reminder
                           self.presentationMode.wrappedValue.dismiss()
                       }) {
                           Text("Back")
                       },
                       trailing:Button(action: {
                           self.presentationMode.wrappedValue.dismiss()
                       }) {
                           Text("Cancel")
                       }
                   )
               }
        
    }
    
    
    func saveReminder() { // When are minder is saved it is processed through UserManager and added into the data container. This is where the reminders are stored 
        print("addReminder in UserManager called with title: \(title)")
        userManager.addReminder(title: title, time: time, description: desc, date: date, setBy: userManager.currentUser?.username ?? "Unknown")
        self.presentationMode.wrappedValue.dismiss()
    }
    

    
    
}
