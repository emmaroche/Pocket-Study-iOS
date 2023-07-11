//
//  LaunchScreenView.swift
//  PocketStudy
//
//  Created by Emma Roche on 11/07/2023.
//

import SwiftUI

// The following resource was used to assist with the development of this file: https://holyswift.app/animated-launch-screen-in-swiftui/

struct LaunchScreenView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager // Mark 1

    @State private var firstAnimation = false  // Mark 2
    @State private var secondAnimation = false // Mark 2
    @State private var startFadeoutAnimation = false // Mark 2
    
    
    @ViewBuilder
    private var imageWithText: some View {
        ZStack {
            Image("PSLOGO")
                .resizable()
                .scaledToFit()
                .frame(width: 600, height: 800)
                .rotationEffect(firstAnimation ? Angle(degrees: 360) : Angle(degrees: -360))

            VStack {
                Text("Pocket Study")
                    .foregroundColor(.black)
                    .font(.system(size: 36))
                    .fontWeight(.bold)
                    .padding(.all, 130)

                Spacer()

                Text("A smarter way to study")
                    .foregroundColor(.black)
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .padding(.all, 150)
            }
        }
    }
    
    @ViewBuilder
    private var backgroundColor: some View {  // Mark 3
        Color.white.ignoresSafeArea()
    }
    
    private let animationTimer = Timer // Mark 5
        .publish(every: 0.1, on: .current, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack {
            backgroundColor  // Mark 3
//            image  // Mark 3
            imageWithText
        }.onReceive(animationTimer) { timerValue in
            updateAnimation()  // Mark 5
        }.opacity(startFadeoutAnimation ? 0 : 1)
    }
    
    private func updateAnimation() { // Mark 5
        switch launchScreenState.state {
        case .stepOne:
            withAnimation(.easeInOut(duration: 3)) {
                firstAnimation.toggle()
            }
        case .stepTwo:
            if secondAnimation == false {
                withAnimation(.linear) {
                    self.secondAnimation = true
                    startFadeoutAnimation = true
                }
            }
        case .finished:
            // use this case to finish any work needed
            break
        }
    }
    
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .environmentObject(LaunchScreenStateManager())
    }
}
