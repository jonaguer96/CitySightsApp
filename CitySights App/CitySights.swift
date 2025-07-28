//
//  CitySights_AppApp.swift
//  CitySights App
//
//  Created by Jonathan Guerrero on 6/25/25.
//

import SwiftUI

@main
struct CitySights: App {
    
    @State var model = BusinessModel()
    @AppStorage("onboarding") var needsOnboarding = true
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(model)
                .fullScreenCover(isPresented: $needsOnboarding) {
                    needsOnboarding = false
                } content: {
                    OnBoardingView()
                        .environment(model)
                }
                .onAppear {
                    // If no onboarding is needed; then get user location. 
                    if needsOnboarding == false {
                        model.getUserLocation()
                    }
                }

        }
    }
}

