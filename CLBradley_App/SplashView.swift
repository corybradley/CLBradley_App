//
//  SplashView.swift
//  CLBradley_App
//
//  Created by Cory Bradley on 3/19/26.
//

import SwiftUI

struct SplashView: View {
    @State private var nameOpacity: Double = 0
    @State private var nameOffset: CGFloat = 18
    @State private var locationOpacity: Double = 0

    var body: some View {
        ZStack {
            Color(red: 0.961, green: 0.941, blue: 0.910) // #F5F0E8 warm parchment
                .ignoresSafeArea()

            VStack(spacing: 12) {
                Text("C . L . B R A D L E Y")
                    .font(.custom("CLBRADLEY", size: 28))
                    .tracking(5)
                    .foregroundColor(Color(red: 0.102, green: 0.102, blue: 0.102)) // #1A1A1A
                    .opacity(nameOpacity)
                    .offset(y: nameOffset)

                Text("Charleston, SC")
                    .font(.system(size: 10, weight: .regular))
                    .tracking(5)
                    .foregroundColor(Color(red: 0.467, green: 0.467, blue: 0.467)) // #777777
                    .textCase(.uppercase)
                    .opacity(locationOpacity)
            }

            VStack {
                Spacer()
                Image("logo_transparent")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 44, height: 44)
                    .opacity(locationOpacity)
                    .padding(.bottom, 48)
            }
        }
        .onAppear {
            // Name fades and rises in over 1.6s
            withAnimation(.easeOut(duration: 1.6)) {
                nameOpacity = 1
                nameOffset = 0
            }
            // "Charleston, SC" fades in 0.8s after name starts
            withAnimation(.easeIn(duration: 0.8).delay(0.8)) {
                locationOpacity = 1
            }
        }
    }
}

// MARK: - Root coordinator

struct RootView: View {
    @State private var showSplash = true

    var body: some View {
        ZStack {
            ContentView()
                .opacity(showSplash ? 0 : 1)

            if showSplash {
                SplashView()
                    .transition(.opacity)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.easeInOut(duration: 0.4)) {
                    showSplash = false
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
