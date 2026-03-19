//
//  ContentView.swift
//  CLBradley_App
//
//  Created by Cory Bradley on 3/16/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var store = ArtworkStore()
    @State private var isDark: Bool = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TabView {
                GalleryView()
                    .tabItem {
                        Label("Gallery", systemImage: "rectangle.grid.2x2")
                    }

                AboutView()
                    .tabItem {
                        Label("About", systemImage: "person")
                    }

                InstagramView()
                    .tabItem {
                        Label("Instagram", systemImage: "camera")
                    }
            }
            .tint(.primary)
            .environmentObject(store)
            .preferredColorScheme(isDark ? .dark : .light)

            Button {
                isDark.toggle()
            } label: {
                Image(systemName: isDark ? "sun.max.fill" : "moon.fill")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.primary)
                    .frame(width: 44, height: 44)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }
            .padding(.trailing, 20)
            .padding(.bottom, 90)
        }
    }
}

#Preview {
    ContentView()
}
