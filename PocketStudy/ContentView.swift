//
//  ContentView.swift
//  PocketStudy
//
//  Created by Emma Roche on 11/07/2023.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    
    var body: some View {
        VStack {
            Image(systemName: "applescript")
                .resizable()
                .scaledToFit()
                .foregroundColor(.accentColor)
                .frame(width: 150, height: 150)

          
            Text("Hello").font(.largeTitle)
        }
        .padding()
        .task {
//            try? await getDataFromApi()
            try? await Task.sleep(for: Duration.seconds(1.5))
            self.launchScreenState.dismiss()
        }
    }
    
//    fileprivate func getDataFromApi() async throws {
//        let googleURL = URL(string: "https://www.google.com")!
//        let (_,response) = try await URLSession.shared.data(from: googleURL)
//        print(response as? HTTPURLResponse as Any)
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LaunchScreenStateManager())
    }
}
