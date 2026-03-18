//
//  ContentView.swift
//  CLBradley_App
//
//  Created by Cory Bradley on 3/16/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var store = ArtworkStore()

    var body: some View {
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
    }
}

#Preview {
    ContentView()
}
