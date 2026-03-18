//
//  ArtworkStore.swift
//  CLBradley_App
//
//  Created by Cory Bradley on 3/16/26.
//

import Foundation
import Combine

/// Single source of truth for all artwork data.
final class ArtworkStore: ObservableObject {
    @Published private(set) var artworks: [Artwork]

    init() {
        artworks = ArtworkStore.sampleArtworks
    }

    var newest: [Artwork] {
        artworks.filter(\.isNewest)
    }

    var all: [Artwork] {
        artworks
    }
}

// MARK: - Artwork collection
private extension ArtworkStore {
    static let sampleArtworks: [Artwork] = [
        Artwork(
            title: "Brook'a'lyn",
            medium: "Oil on board",
            size: "53 × 40 in",
            year: 2020,
            imageName: "brooklyn",
            isNewest: true,
            collection: "Private Collection"
        ),
        Artwork(
            title: "King Cashus",
            medium: "Oil on wood",
            size: "",
            year: 2017,
            imageName: "still_waters",
            isNewest: true,
            collection: "Private Collection"
        ),
        Artwork(
            title: "Apabo",
            medium: "Oil on board",
            size: "55 × 40 in",
            year: 2024,
            imageName: "apollo",
            isNewest: true,
            collection: "Private Collection"
        ),
        Artwork(
            title: "DJ Commission",
            medium: "Oil on board",
            size: "16 × 24 in",
            year: 2025,
            imageName: "morning_light"
        ),
        Artwork(
            title: "Stained Glass Study",
            medium: "Oil on board",
            size: "30 × 30 in",
            year: 2025,
            imageName: "golden_hour"
        ),
        Artwork(
            title: "Stained Glass Study 2",
            medium: "Oil on board",
            size: "30 × 30 in",
            year: 2025,
            imageName: "autumn_study"
        ),
    ]
}
