//
//  ArtworkDetailView.swift
//  CLBradley_App
//
//  Created by Cory Bradley on 3/16/26.
//

import SwiftUI

struct ArtworkDetailView: View {
    let artwork: Artwork
    let allArtworks: [Artwork]
    let onDismiss: () -> Void

    @State private var currentIndex: Int

    init(artwork: Artwork, allArtworks: [Artwork], onDismiss: @escaping () -> Void) {
        self.artwork = artwork
        self.allArtworks = allArtworks
        self.onDismiss = onDismiss
        let index = allArtworks.firstIndex(where: { $0.id == artwork.id }) ?? 0
        _currentIndex = State(initialValue: index)
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.white.ignoresSafeArea()

            VStack(spacing: 0) {
                // Signature header — same as every other page
                ZStack {
                    Text("C . L . B R A D L E Y")
                        .font(.custom("CLBRADLEY", size: 28))
                        .tracking(3)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                }
                .frame(height: 52)
                .background(Color.white)

                Divider()

                // Swipeable painting pages fill the remaining space
                TabView(selection: $currentIndex) {
                    ForEach(Array(allArtworks.enumerated()), id: \.offset) { index, item in
                        DetailPage(artwork: item)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }

            // Close button — overlaid top-left, always accessible
            Button(action: onDismiss) {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.primary)
                    .frame(width: 34, height: 34)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }
            .padding(.top, 10)
            .padding(.leading, 16)
        }
    }
}

// MARK: - Single page inside the TabView

private struct DetailPage: View {
    let artwork: Artwork
    @State private var showMetadata = false

    var body: some View {
        GeometryReader { screen in
            ScrollView {
                VStack(spacing: 0) {
                    if UIImage(named: artwork.imageName) != nil {
                        Image(artwork.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: screen.size.width)
                    } else {
                        Rectangle()
                            .fill(Color(.systemGray6))
                            .frame(width: screen.size.width, height: screen.size.width)
                            .overlay(
                                Image(systemName: "photo")
                                    .foregroundColor(Color(.systemGray4))
                                    .font(.title2)
                            )
                    }

                    // Metadata — fades in after image
                    VStack(alignment: .leading, spacing: 0) {
                        Text(artwork.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(Color.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 10)

                        Text(artwork.mediumAndSize)
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(Color(.systemGray))

                        Text(String(artwork.year))
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(Color(.systemGray))
                            .padding(.top, 2)

                        if let collection = artwork.collection {
                            Text(collection)
                                .font(.system(size: 11, weight: .regular))
                                .tracking(1)
                                .foregroundColor(Color(.systemGray3))
                                .padding(.top, 8)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                    .padding(.bottom, 40)
                    .opacity(showMetadata ? 1 : 0)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            withAnimation(.easeInOut(duration: 0.45)) {
                                showMetadata = true
                            }
                        }
                    }
                    .onDisappear {
                        showMetadata = false
                    }
                }
                .frame(
                    minWidth: screen.size.width,
                    minHeight: screen.size.height,
                    alignment: .center
                )
            }
            .background(Color.white)
        }
    }
}

#Preview {
    ArtworkDetailView(
        artwork: ArtworkStore().all[0],
        allArtworks: ArtworkStore().all,
        onDismiss: {}
    )
}
