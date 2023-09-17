//
//  iosDevApp.swift
//  iosDev
//
//  Created by Isabelle Brian on 12/9/2023.
//

import SwiftUI


@main // Main , this is the iosDevApp
struct iosDevApp: App {
    let persistenceController = PersistenceController.shared // establishing persistance Controller
    let userManager = UserManager(context: PersistenceController.shared.container.viewContext) // User Manager, core data
    
   
    init() {
        // Change the background color
        UITabBar.appearance().barTintColor = UIColor.red

        // Change the item color
        UITabBar.appearance().tintColor = UIColor.white

        // Change of  unselected tab item 
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
      
