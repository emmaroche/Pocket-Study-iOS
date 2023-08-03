//
//  LoadingView.swift
//  PocketStudy
//
//  Created by Emma Roche on 03/08/2023.
//

import SwiftUI

// Loading View

struct LoadingView: View {
    @State var animation = false
    
    var body: some View{
        VStack{
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(CustomColour.DefaultBlue, lineWidth: 8)
                .frame(width: 75, height: 75)
                .rotationEffect(.init(degrees: animation ? 360 : 0))
                .padding(50)
        }
        .background(Color.white)
        .cornerRadius(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.4).ignoresSafeArea(.all, edges: .all))
        .onAppear(perform: {
            withAnimation(Animation.linear(duration: 3)) {
                animation.toggle()
            }
        })
        
    }
}
