//
//  LaunchScreenStateManager.swift
//  PocketStudy
//
//  Created by Emma Roche on 11/07/2023.
//

// The following resource was used to assist with the development of this file: https://holyswift.app/animated-launch-screen-in-swiftui/

import Foundation; final class LaunchScreenStateManager: ObservableObject {

@MainActor @Published private(set) var state: LaunchScreenSteps = .stepOne

    @MainActor func dismiss() {
        Task {
            state = .stepTwo

            try? await Task.sleep(for: Duration.seconds(1))

            self.state = .finished
        }
    }
}
