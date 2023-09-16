import SwiftUI

struct ReminderListView: View {
    @State private var reminders: [ReminderItem] = [ReminderItem(id: UUID(), title: "Sample Reminder", date: Date())]  // Added a sample reminder
    @State private var showAddReminder = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(reminders) { reminder in
                        ReminderRow(reminder: reminder, onDelete: { reminderItem in
                            if let index = reminders.firstIndex(where: { $0.id == reminderItem.id }) {
                                reminders.remove(at: index)
                            }
                        })
                    }
                }

                Spacer()

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
                AddReminderView()
            }
            .navigationTitle("Reminders")
        }
    }
}

struct ReminderRow: View {
    let reminder: ReminderItem
    var onDelete: ((ReminderItem) -> Void)? = nil

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(reminder.title)
                    .font(.headline)
                Text(reminder.date, style: .date)
                    .font(.subheadline)
            }
            Spacer()
            Button(action: {
                onDelete?(reminder)
            }) {
                Image(systemName: "trash")
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}

struct ReminderItem: Identifiable {
    var id: UUID
    var title: String
    var date: Date
}

