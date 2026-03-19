//
//  AboutView.swift
//  CLBradley_App
//
//  Created by Cory Bradley on 3/16/26.
//

import SwiftUI

struct AboutView: View {

    private let statement = """
        An Artist. Black Man. Son. Husband. Father. American. \
        Panthers/Warriors Fan. Amateur Woodworker. Beer Pong Boss. \
        Movie Aficionado. Meat-Eater. IT Engineer. Friend. Patient. \
        Big Brother. Little Brother. Student of Earth. Dog Father. \
        Lover. Fighter. Home Owner. Californian. Ex-Carolinian. \
        Ex-Floridian. Ex-New Yorker. Ex-Volunteer. Life long Govie. \
        Lego Lover. Photographer. World Traveler. Coach. Mario Kart \
        Menace. Failure. Winner. Smart-Ass. Chef. Electric Car Owner. \
        Jerk. Sneaker Head. Asthmatic. Author. Illustrator. And an \
        overall Nice Guy.
        """

    @State private var showEasterEgg = false
    @State private var tapCount = 0

    private let version: String = {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }()

    var body: some View {
        NavigationStack {
            ZStack {
            ScrollView {
                VStack(alignment: .center, spacing: 0) {
                    Text("C . L . B R A D L E Y")
                        .font(.custom("CLBRADLEY", size: 32))
                        .foregroundStyle(Color.primary)
                        .tracking(3)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 8)

                    Text("Painter")
                        .font(.system(size: 10, weight: .regular))
                        .tracking(4)
                        .foregroundColor(Color(.systemGray2))
                        .textCase(.uppercase)

                    Divider()
                        .padding(.top, 28)
                        .padding(.bottom, 28)

                    VStack(alignment: .leading, spacing: 0) {
                        StatementSection(heading: "I Am.") {
                            Text(statement)
                                .font(.custom("Georgia", size: 15))
                                .foregroundColor(Color(.systemGray))
                                .lineSpacing(8)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }

                        Text("I don't bite. Reach out.")
                            .font(.custom("Georgia-Italic", size: 17))
                            .foregroundColor(Color(.systemGray2))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 28)

                        Divider()
                            .padding(.top, 32)
                            .padding(.bottom, 28)

                        StatementSection(heading: "Contact") {
                            Text("hello@clbradley.com")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Color(.systemGray))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer(minLength: 60)
                }
                .padding(.horizontal, 28)
                .padding(.top, 40)
            }
            .background(Color(.systemBackground))

            VStack {
                Spacer()
                Image("logo_transparent")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 44, height: 44)
                    .padding(.bottom, 48)
                    .gesture(
                        LongPressGesture(minimumDuration: 0.6)
                            .onEnded { _ in
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                showEasterEgg = true
                            }
                    )
            }

            // Easter egg overlay
            if showEasterEgg {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture { showEasterEgg = false }

                VStack(spacing: 8) {
                    Text("C.L. Bradley")
                        .font(.custom("CLBRADLEY", size: 22))
                        .foregroundColor(.white)

                    Text("Designed & built by Cory Bradley")
                        .font(.system(size: 11, weight: .regular))
                        .foregroundColor(Color(red: 0.533, green: 0.533, blue: 0.533)) // #888888

                    Text("iOS · SwiftUI · 2026")
                        .font(.system(size: 10, weight: .regular))
                        .foregroundColor(Color(red: 0.400, green: 0.400, blue: 0.400)) // #666666

                    Text("V 2.0")
                        .font(.system(size: 10, weight: .regular))
                        .foregroundColor(Color(red: 0.400, green: 0.400, blue: 0.400)) // #666666
                        .padding(.top, 2)
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 28)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(red: 0.102, green: 0.102, blue: 0.102)) // #1A1A1A
                )
                .padding(.horizontal, 48)
                .onTapGesture { showEasterEgg = false }
            }

            } // ZStack
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("A B O U T")
                        .font(.system(size: 11, weight: .light))
                        .tracking(4)
                        .foregroundColor(.primary)
                }

            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct StatementSection<Content: View>: View {
    let heading: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(heading.uppercased())
                .font(.system(size: 9, weight: .regular))
                .tracking(3.5)
                .foregroundColor(Color(.systemGray3))
            content
        }
    }
}

#Preview {
    AboutView()
}
