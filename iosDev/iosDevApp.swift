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
    let userManager = UserManager(context: PersistenceController.shared.container.viewContext) // Create the UserManager instance here
   

        var body: some Scene {   
        WindowGroup {
            Main()
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            .environmentObject(userManager)
        }
    }
}
