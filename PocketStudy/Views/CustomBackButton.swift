//
//  CustomBackButton.swift
//  PocketStudy
//
//  Created by Emma Roche on 12/07/2023.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.backward")
                .imageScale(.large)
                .foregroundColor(Color.black)
        }
    }
}
