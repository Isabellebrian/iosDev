import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userManager: UserManager // Adding user manager
    
    init() { // This is the init method i used to change color of the navigation bar
        UITabBar.appearance().barTintColor = UIColor.lightGray
        UITabBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }
    
    var body: some View { // view, this makes the Main view as the first displayed view
        if userManager.isAuthenticated {
            UserNavigationView()
        } else {
            Main()
        }
    }
}

struct UserNavigationView: View {
    var body: some View {
        TabView {
            
            // Reminder List View
            NavigationView {
                ReminderListView() // This is the first tab, users will be taken here after login.
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Reminders")
            }

            // Home View
            NavigationView {
                Main()
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }

            // Task List View
            NavigationView {
                ListView()
            }
            .tabItem {
                Image(systemName: "text.badge.checkmark")
                Text("Tasks")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
