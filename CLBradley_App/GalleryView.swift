//
//  GalleryView.swift
//  CLBradley_App
//
//  Created by Cory Bradley on 3/16/26.
//

import SwiftUI

struct GalleryView: View {
    @EnvironmentObject var store: ArtworkStore
    @State private var selectedArtwork: Artwork? = nil

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        ZStack {
            NavigationStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        if !store.newest.isEmpty {
                            SectionLabel("Newest Works")
                                .padding(.horizontal, 16)
                                .padding(.top, 24)
                                .padding(.bottom, 14)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(store.newest) { artwork in
                                        NewestCard(artwork: artwork)
                                            .onTapGesture { selectedArtwork = artwork }
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.bottom, 28)
                            }
                        }

                        SectionLabel("All Works")
                            .padding(.horizontal, 16)
                            .padding(.bottom, 14)

                        LazyVGrid(columns: columns, spacing: 12) {
                            ForEach(store.all) { artwork in
                                GridTile(artwork: artwork)
                                    .onTapGesture { selectedArtwork = artwork }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 100)
                    }
                }
                .background(Color(.systemBackground))
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("C . L . B R A D L E Y")
                            .font(.custom("CLBRADLEY", size: 32))
                            .tracking(3)
                            .foregroundColor(.primary)
                    }

                }
                .navigationBarTitleDisplayMode(.inline)
            }

            if let artwork = selectedArtwork {
                ArtworkDetailView(
                    artwork: artwork,
                    allArtworks: store.all,
                    onDismiss: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            selectedArtwork = nil
                        }
                    }
                )
                .transition(.opacity)
                .zIndex(1)
            }
        }
        .animation(.easeInOut(duration: 0.35), value: selectedArtwork != nil)
    }
}

// MARK: - Section label

private struct SectionLabel: View {
    let title: String
    init(_ title: String) { self.title = title }

    var body: some View {
        Text(title.uppercased())
            .font(.system(size: 10, weight: .regular))
            .tracking(3)
            .foregroundColor(Color(.systemGray2))
    }
}

// MARK: - Newest Works Card

private struct NewestCard: View {
    let artwork: Artwork

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ArtworkImage(name: artwork.imageName)
                .scaledToFill()
                .frame(width: 260, height: 320)
                .clipped()

            Text(artwork.title)
                .font(.headline)
                .foregroundStyle(Color.primary)

            Text(artwork.mediumAndSize)
                .font(.caption)
                .foregroundStyle(Color(white: 0.3))

            Text(String(artwork.year))
                .font(.caption)
                .foregroundStyle(Color(white: 0.3))
        }
        .frame(width: 260)
        .contentShape(Rectangle())
    }
}

// MARK: - Grid Tile

private struct GridTile: View {
    let artwork: Artwork

    var body: some View {
        Color.clear
            .aspectRatio(4/5, contentMode: .fill)
            .overlay(
                ArtworkImage(name: artwork.imageName)
                    .scaledToFill()
            )
            .clipped()
            .contentShape(Rectangle())
    }
}

// MARK: - Artwork Image helper

struct ArtworkImage: View {
    let name: String

    var body: some View {
        if UIImage(named: name) != nil {
            Image(name)
                .resizable()
        } else {
            Rectangle()
                .fill(Color(.systemGray6))
                .overlay(
                    Image(systemName: "photo")
                        .foregroundColor(Color(.systemGray4))
                        .font(.title2)
                )
        }
    }
}

#Preview {
    GalleryView()
        .environmentObject(ArtworkStore())
}
