//
//  AddReminderView.swift
//  iosDev
//
//  Created by Isabelle Brian on 16/9/2023.
//
import SwiftUI

struct AddReminderView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userManager: UserManager


    @State private var title: String = ""
    @State private var time: Date = Date()
    @State private var desc: String = ""
    @State private var date: Date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    TextField("Title", text: $title)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    DatePicker("Time", selection: $time, displayedComponents: .hourAndMinute)
                    TextField("Description", text: $desc)
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
            .navigationBarItems(
                leading: Button(action: {
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
    
    
    func saveReminder() {
        print("addReminder in UserManager called with title: \(title)")
        userManager.addReminder(title: title, time: time, description: desc, date: date, setBy: userManager.currentUser?.username ?? "Unknown")
        self.presentationMode.wrappedValue.dismiss()
    }
    

    
    
}
