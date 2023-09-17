//
//  iosDevApp.swift
//  iosDev
//
//  Created by Isabelle Brian on 12/9/2023.
//

import SwiftUI


@main
struct iosDevApp: App {
    let persistenceController = PersistenceController.shared
    let userManager = UserManager(context: PersistenceController.shared.container.viewContext)
    
   
    init() {
        // Change the tab bar's background color
        UITabBar.appearance().barTintColor = UIColor.red

        // Change the active tab item color
        UITabBar.appearance().tintColor = UIColor.white

        // Change the unselected tab item color
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }
    var body: some Scene {
           WindowGroup {
               ContentView() // Use ContentView with TabView
                   .environment(\.managedObjectContext, persistenceController.container.viewContext)
                   .environmentObject(userManager)
           }
       }
   }
      
