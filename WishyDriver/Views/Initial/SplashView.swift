//
//  SplashView.swift
//  Wishy
//
//  Created by Karim Amsha on 27.04.2024.
//

import SwiftUI

struct SplashView: View {
    @State private var logoOpacity: Double = 0.0

    var body: some View {
        ZStack {
            Color.primaryGradientColor()
                .ignoresSafeArea()

            Image("ic_logo")
                .opacity(logoOpacity)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 3)) {
                self.logoOpacity = 1.0
//                UserSettings.shared.loggedIn = true
            }
        }
    }
}

#Preview {
    SplashView()
}
