//
//  Artwork.swift
//  CLBradley_App
//
//  Created by Cory Bradley on 3/16/26.
//

import Foundation

struct Artwork: Identifiable, Hashable {
    let id: UUID
    let title: String
    let medium: String
    let size: String
    let year: Int
    /// Name of the image asset stored locally in Assets.xcassets
    let imageName: String
    let isNewest: Bool
    /// Optional provenance note, e.g. "Private Collection"
    let collection: String?

    init(
        id: UUID = UUID(),
        title: String,
        medium: String,
        size: String,
        year: Int,
        imageName: String,
        isNewest: Bool = false,
        collection: String? = nil
    ) {
        self.id = id
        self.title = title
        self.medium = medium
        self.size = size
        self.year = year
        self.imageName = imageName
        self.isNewest = isNewest
        self.collection = collection
    }

    /// Convenience display string, e.g. "Oil on canvas · 24 × 36 in"
    var mediumAndSize: String {
        "\(medium) · \(size)"
    }
}
