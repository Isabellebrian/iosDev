//
//  AddTaskView.swift
//  iosDev
//
//  Created by Isabelle Brian on 14/9/2023.
//

import SwiftUI

// This is the AddTask sheet for the List View
struct AddTaskView: View {
    @Binding var tasks: [Task]
    @State private var title: String = ""
    @State private var selectedCategory: Task.Category = .personal
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form { // form that users will fill in to add a task to the List view
                TextField("Task Title", text: $title)
                Picker("Category", selection: $selectedCategory) { // This is a selector element allows users to assign subcategories to a task
                    ForEach(Task.Category.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                Button("Add Task") { // UI button, adds the task to the view. This is then passed on to the User Manager
                    let newTask = Task(title: title, date: Date(), Category: selectedCategory)
                    tasks.append(newTask)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationBarItems(trailing: Button("Cancel") { // To exit the sheet
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
