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
            Color(.systemBackground).ignoresSafeArea()

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
                .background(Color(.systemBackground))

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
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0

    var body: some View {
        GeometryReader { screen in
            ScrollView {
                VStack(spacing: 0) {
                    if UIImage(named: artwork.imageName) != nil {
                        Image(artwork.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: screen.size.width)
                            .scaleEffect(scale, anchor: .center)
                            .simultaneousGesture(
                                MagnificationGesture()
                                    .onChanged { value in
                                        let delta = value / lastScale
                                        lastScale = value
                                        scale = min(max(scale * delta, 1.0), 2.0)
                                    }
                                    .onEnded { _ in
                                        lastScale = 1.0
                                        withAnimation(.spring(response: 0.35,
                                                              dampingFraction: 0.75)) {
                                            scale = min(max(scale, 1.0), 2.0)
                                        }
                                    }
                            )
                            .zIndex(1)
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
                            .foregroundStyle(Color.primary)
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

                        Button(action: shareArtwork) {
                            Label("Share", systemImage: "square.and.arrow.up")
                                .font(.system(size: 13, weight: .regular))
                                .foregroundColor(Color(.systemGray))
                        }
                        .padding(.top, 16)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                    .padding(.bottom, 40)
                    .opacity(showMetadata ? 1 : 0)
                    .zIndex(0)
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
            .background(Color(.systemBackground))
        }
    }

    func shareArtwork() {
        guard let image = UIImage(named: artwork.imageName)
            else { return }
        let text = "\(artwork.title) by C.L. Bradley"
        let activityVC = UIActivityViewController(
            activityItems: [image, text],
            applicationActivities: nil
        )
        if let windowScene = UIApplication.shared
            .connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows
               .first?.rootViewController {
            rootVC.present(activityVC, animated: true)
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

// MARK: - Conditional modifier helper

extension View {
    @ViewBuilder
    func `if`<Transform: View>(
        _ condition: Bool,
        transform: (Self) -> Transform
    ) -> some View {
        if condition { transform(self) }
        else { self }
    }
}
