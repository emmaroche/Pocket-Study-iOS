//
//  WelcomeScreens.swift
//  PocketStudy
//
//  Created by Emma Roche on 11/07/2023.
//

// The following resource was used to assist with the development of this file: https://swiftuirecipes.com/blog/swiftui-radio-buttons?utm_content=cmp-true

import SwiftUI

struct RadioButton<Tag, CircleButton, Label>: View
where Tag : Hashable, CircleButton : View, Label : View {
    let tag: Tag
    @Binding var selection: Tag?
    @ViewBuilder let button: (Bool) -> CircleButton
    @ViewBuilder let label: () -> Label
    
    var body: some View {
        Button {
            selection = tag
        } label: {
            HStack {
                button(selection == tag)
                label()
            }
        }
        .buttonStyle(.plain)
    }
}

struct RadioButtonGroup<Tag, CircleButton, Label>: View
where Tag : Hashable, CircleButton : View, Label : View {
    @Binding var selection: Tag?
    let orientation: Orientation
    let tags: [Tag]
    @ViewBuilder let button: (Bool) -> CircleButton
    @ViewBuilder let label: (Tag) -> Label
    
    var body: some View {
        ((orientation == .horizonal)
         ? AnyLayout(HStackLayout(alignment: .top))
         : AnyLayout(VStackLayout(alignment: .leading))) {
            ForEach(tags, id: \.self) { tag in
                RadioButton(tag: tag, selection: $selection, button: button) {
                    label(tag)
                }
            }
        }
    }
    
    enum Orientation {
        case horizonal, vertical
    }
}

struct WelcomeScreens: View {
    
    
    @State private var selection: Option? = .first // Sets the initial/default value to .first
    
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    
    var body: some View {
        NavigationView {
            VStack() {
                
                Image("PSLOGOBIG")
                    .resizable()
                    .frame(width: 270, height: 270)
                    .padding(.all, 30)
                
                Text("\(selection?.title ?? " ")")
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.1)
                    .padding(.bottom, UIScreen.main.bounds.width * 0.05)
                    .font(.system(size: UIScreen.main.bounds.width * 0.06))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                
                Divider()
                    .frame(width: UIScreen.main.bounds.width * 0.5, height: 1)
                    .background(Color.black)
                    .padding(.bottom, UIScreen.main.bounds.width * 0.05)
                
                Text("\(selection?.description ?? " ")")
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.1)
                    .font(.system(size: UIScreen.main.bounds.width * 0.04))
                    .multilineTextAlignment(.center)
                
                
                RadioButtonGroup(selection: $selection,
                                 orientation: .horizonal,
                                 tags: Option.allCases,
                                 button: { isSelected in
                    
                    ZStack {
                        
                        Circle()
                            .foregroundColor(CustomColour.DefaultBlue)
                            .frame(width: 28, height: 28)
                            .padding(.all, 30)
                        
                        if isSelected {
                            Circle()
                                .foregroundColor(Color.white)
                                .frame(width: 16, height: 16)
                                .padding(.all, 30)
                        }
                    }
                },
                                 label: { tag in
                    Text("")
                })
                
                
                NavigationLink(destination: LoginScreen()) {
                    Text("Get Started")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .padding(.horizontal, 120)
                        .padding(.vertical, 15)
                        .foregroundColor(.black)
                        .background(CustomColour.DefaultBlue)
                        .cornerRadius(12)
                    
                    
                }.padding(.top, 30)
            }
            
            
            Spacer()
        }.task {
            try? await Task.sleep(for: Duration.seconds(1.5))
            self.launchScreenState.dismiss()
        }
    }
    
    
    enum Option: CaseIterable, CustomStringConvertible {
        case first, second, third
        
        var description: String {
            switch self {
            case .first:
                return "Effortlessly manage your study materials, goals and deadlines in one central study hub."
            case .second:
                return "Pocket Study empowers you to take control of your academic success. No more feeling overwhelmed or lost."
            case .third:
                return "With our cutting-edge features, organising, tracking and staying on top of tour study goals has never been easier."
            }
        }
        
        var title: String {
            switch self {
            case .first:
                return "Welcome to a smarter way to study"
            case .second:
                return "Boost your productivity and achieve academic success!"
            case .third:
                return "Get ready to conquer your academic goals"
            }
        }
    }
}

struct WelcomeScreens_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreens().environmentObject(LaunchScreenStateManager())
    }
}
