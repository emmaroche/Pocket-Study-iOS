//
//  PocketStudyApp.swift
//  PocketStudy
//
//  Created by Emma Roche on 11/07/2023.
//

import SwiftUI
import FirebaseCore
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct PocketStudyApp: App {
    
    @StateObject var launchScreenState = LaunchScreenStateManager()
    
    // Registering app delegate for Firebase setup
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @State private var loggedIn = false 
    
    var body: some Scene {
        WindowGroup {
            if loggedIn {
                HomeView()
            } else {
                ZStack {
                    WelcomeScreens()

                    if launchScreenState.state != .finished {
                        LaunchScreenView()
                    }
                }
                .environmentObject(launchScreenState)
                .onAppear {
                    // Observer to listen for authentication state changes
                    Auth.auth().addStateDidChangeListener { (auth, user) in
                        loggedIn = user != nil
                    }
                }
            }
        }
    }
}

