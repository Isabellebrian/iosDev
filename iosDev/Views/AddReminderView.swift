//
//  AddReminderView.swift
//  iosDev
//
//  Created by Isabelle Brian on 16/9/2023.
//
import SwiftUI

struct AddReminderView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var UserManager: UserManager  // Assuming you have some data manager to handle Core Data operations

    @State private var title: String = ""
    @State private var time: Date = Date()
    @State private var setBy: String = ""
    @State private var description: String = ""
    @State private var date: Date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Reminder Details")) {
                    TextField("Title", text: $title)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    DatePicker("Time", selection: $time, displayedComponents: .hourAndMinute)
                    TextField("Set By", text: $setBy)
                    TextField("Description", text: $description)
                }
                
                Button(action: saveReminder) {
                    Text("Save Reminder")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .navigationBarTitle("Add Reminder", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Cancel")
            })
        }
    }
    
    func saveReminder() {
        // Here you'd have your logic to save the reminder to Core Data.
        // Utilize your dataManager or equivalent to handle this.
        
        // For now, I'll just dismiss the view after the save attempt:
        self.presentationMode.wrappedValue.dismiss()
    }
}
