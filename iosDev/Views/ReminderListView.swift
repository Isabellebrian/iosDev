import SwiftUI

struct ReminderListView: View {
    @State private var reminders: [ReminderItem] = []
    @State private var showAddReminder = false
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        List {
            ForEach(reminders) { reminder in
                ReminderRow(reminder: reminder, onDelete: { reminderItem in
                    if let index = reminders.firstIndex(where: { $0.id == reminderItem.id }) {
                        reminders.remove(at: index)
                    }
                })
            }
            .onDelete { indexSet in
                reminders.remove(atOffsets: indexSet)
            }
        }
        .listStyle(PlainListStyle())
        .onAppear(perform: fetchReminders)
        .navigationBarTitle("Reminders", displayMode:  .large)
        .navigationBarItems(leading: Button("Clear All") {
            if userManager.clearAllReminders() {
                print("All reminders cleared!")
                reminders.removeAll()
            } else {
                print("Failed to clear reminders!")
            }
        }, trailing: Button("Add Reminder", action: {
            showAddReminder = true
        }))
        .sheet(isPresented: $showAddReminder, onDismiss: fetchReminders) {
            AddReminderView().environmentObject(self.userManager)
        }
    }

    func fetchReminders() {
        let fetchedReminders = self.userManager.fetchReminders().map {
            ReminderItem(id: $0.id ?? UUID(), title: $0.title ?? "", date: $0.date ?? Date(), time: $0.time ?? Date(), setBy: $0.setBy ?? "", desc: $0.desc ?? "")
        }
        self.reminders = fetchedReminders
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
                Text("Set by: \(reminder.setBy)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(reminder.desc)
                    .font(.subheadline)
                Text(reminder.date, style: .date)
                    .font(.subheadline)
                Text(reminder.time, style: .time)
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
        .padding(.vertical, 8)
    }
}

struct ReminderItem: Identifiable {
    var id: UUID
    var title: String
    var date: Date
    var time: Date
    var setBy: String
    var desc: String
}
