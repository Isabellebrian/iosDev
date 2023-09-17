import SwiftUI

struct ReminderListView: View { // Reminder list view!
    @State private var reminders: [ReminderItem] = [] // State that has all the list of reminders created by users
    @State private var showAddReminder = false // Reminder display is initiall set to false
    @EnvironmentObject var userManager: UserManager // Calling userManager , gives access to ReminderList
    
    var body: some View {
        List {
            ForEach(reminders) { reminder in // for loop , goes through each reminder setby that user who logged in and presents them in the view.
                ReminderRow(reminder: reminder, onDelete: { reminderItem in // OnDelete
                    if let index = reminders.firstIndex(where: { $0.id == reminderItem.id }) { // filters through unique id, each reminder gets passed and is assigned with the OnDelete modifier
                        reminders.remove(at: index) // removes the reminder from the array index!
                    }
                })
            }
            .onDelete { indexSet in // allows users to swipe and delete the reminder
                reminders.remove(atOffsets: indexSet)
            }
        }
        .listStyle(PlainListStyle()) // another UI design element modifier
        .onAppear(perform: fetchReminders) // retrieves the reminders for the user to see
        .navigationBarTitle("Reminders", displayMode:  .large) // navigation to display the title of the view
        .navigationBarItems(leading: Button("Clear All") { // clear button for users to clear all reminders
            if userManager.clearAllReminders() {
                print("All reminders cleared!")
                reminders.removeAll()
            } else {
                print("Failed to clear reminders!")
            }
        }, trailing: Button("Add Reminder", action: { // allows users to add a reminder, this triggers the AddReminder view sheet
            showAddReminder = true
        }))
        .sheet(isPresented: $showAddReminder, onDismiss: fetchReminders) {
            AddReminderView().environmentObject(self.userManager)
        }
    }

    
    // This function fetches the reminders, has access to user Manager and gets the reminders from there
    func fetchReminders() {
        let fetchedReminders = self.userManager.fetchReminders().map {
            ReminderItem(id: $0.id ?? UUID(), title: $0.title ?? "", date: $0.date ?? Date(), time: $0.time ?? Date(), setBy: $0.setBy ?? "", desc: $0.desc ?? "")
        }
        self.reminders = fetchedReminders // clarifying  use of variable reminders
    }
}

// This is how each reminder will look like, it includes a title, set by , description and time, date

struct ReminderRow: View {
    let reminder: ReminderItem // reminder item state
    var onDelete: ((ReminderItem) -> Void)? = nil // onDelete  modifier

    var body: some View {
        HStack { // Using H stack this time as the reminders will be set horizontally
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
            Spacer() // ading space here
            Button(action: {
                onDelete?(reminder)
            }) {
                Image(systemName: "trash") // icon that carries out the Ondelete
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding(.vertical, 8)
    }
}
// this is the data model represented 
struct ReminderItem: Identifiable {
    var id: UUID
    var title: String
    var date: Date
    var time: Date
    var setBy: String
    var desc: String
}
