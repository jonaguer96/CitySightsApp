//
//  CitySights_AppApp.swift
//  CitySights App
//
//  Created by Jonathan Guerrero on 6/25/25.
//

import SwiftUI

@main
struct CitySights_AppApp: App {
    
    @State var model = BusinessModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(model)
        }
    }
}

