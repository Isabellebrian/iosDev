import SwiftUI


    struct ReminderListView: View {
        @State private var reminders: [ReminderItem] = [ReminderItem(id: UUID(), title: "Sample Reminder", date: Date(), time: Date(), setBy: "Sample User", desc: "Sample Description")]
        @State private var showAddReminder = false
        @EnvironmentObject var userManager: UserManager
        
        var body: some View {
            NavigationView {
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
                    .onAppear {
                        let fetchedReminders = self.userManager.fetchReminders()
                        self.reminders = fetchedReminders.map { ReminderItem(id: $0.id ?? UUID(), title: $0.title ?? "", date: $0.date ?? Date(), time: $0.time ?? Date(), setBy: $0.setBy ?? "", desc: $0.desc ?? "") }
                    }
                    .navigationTitle("Reminders")
                    .navigationBarItems(trailing: Button(action: {
                        showAddReminder.toggle()
                    }) {
                        Text("Add Reminder")
                    })
                    .sheet(isPresented: $showAddReminder) {
                        AddReminderView().environmentObject(self.userManager)
                    }
                }
            }
        
        func addReminderButton() -> some View {
            Button(action: {
                showAddReminder.toggle()
            }) {
                Text("Add Reminder")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
    }

    struct ReminderRow: View {
        let reminder: ReminderItem
        var onDelete: ((ReminderItem) -> Void)? = nil
        
        var body: some View {
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

                HStack {
                    Spacer()
                    Button(action: {
                        onDelete?(reminder)
                    }) {
                        Image(systemName: "trash")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
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
    

