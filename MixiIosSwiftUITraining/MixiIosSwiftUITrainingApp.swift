//
//  MixiIosSwiftUITrainingApp.swift
//  MixiIosSwiftUITraining
//
//  Created by nukopy on 2023/03/24
//

import SwiftUI

@main
struct MixiIosSwiftUITrainingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
