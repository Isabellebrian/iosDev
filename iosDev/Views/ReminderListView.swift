//
//  ReminderView.swift
//  iosDev
//
//  Created by Isabelle Brian on 14/9/2023.
//



//
//  ReminderListView.swift
//  iosDev
//

import SwiftUI

struct ReminderListView: View {
    @State private var reminders: [ReminderItem] = []
    @State private var showAddReminder = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(reminders) { reminder in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(reminder.title)
                                    .font(.headline)
                                Text(reminder.date, style: .date)
                                    .font(.subheadline)
                            }
                            Spacer()
                            Button(action: {
                                // Delete action
                                deleteReminder(at: reminder.id)
                            }) {
                                Image(systemName: "trash")
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }

                Button(action: {
                    showAddReminder.toggle()
                }) {
                    Text("Add Reminder")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .sheet(isPresented: $showAddReminder) {
                // New Reminder View goes here.
            }
            .navigationTitle("Reminders")
        }
    }

    func deleteReminder(at id: UUID) {
        if let index = reminders.firstIndex(where: { $0.id == id }) {
            reminders.remove(at: index)
        }
    }
}

struct ReminderItem: Identifiable {
    var id: UUID
    var title: String
    var date: Date
}
