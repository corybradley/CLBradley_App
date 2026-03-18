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

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .center, spacing: 0) {
                    Text("C . L . B R A D L E Y")
                        .font(.custom("CLBRADLEY", size: 32))
                        .foregroundStyle(Color.black)
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
            .background(Color.white)
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
