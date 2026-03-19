//
//  InstagramView.swift
//  CLBradley_App
//
//  Created by Cory Bradley on 3/16/26.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct InstagramView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Spacer()

                VStack(spacing: 20) {
                    QRCodeView(url: "https://www.instagram.com/clbradley")
                        .frame(width: 220, height: 220)

                    VStack(spacing: 6) {
                        Text("@clbradley")
                            .font(.system(size: 13, weight: .light))
                            .tracking(3)
                            .foregroundColor(.primary)

                        Text("Scan to follow on Instagram")
                            .font(.system(size: 10, weight: .regular))
                            .tracking(2)
                            .foregroundColor(Color(.systemGray3))
                            .textCase(.uppercase)
                    }
                }

                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color(.systemBackground))
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("C . L . B R A D L E Y")
                        .font(.custom("CLBRADLEY", size: 28))
                        .tracking(3)
                        .foregroundColor(.primary)
                }

            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - QR Code View

struct QRCodeView: View {
    let url: String

    var body: some View {
        if let image = generateQRCode(from: url) {
            Image(uiImage: image)
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .background(Color.white)
        } else {
            Rectangle()
                .fill(Color(.systemGray6))
        }
    }

    private func generateQRCode(from string: String) -> UIImage? {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(string.utf8)
        filter.correctionLevel = "M"

        guard let ciImage = filter.outputImage else { return nil }

        let scaled = ciImage.transformed(by: CGAffineTransform(scaleX: 10, y: 10))

        guard let cgImage = context.createCGImage(scaled, from: scaled.extent) else { return nil }

        return UIImage(cgImage: cgImage)
    }
}

#Preview {
    InstagramView()
}
