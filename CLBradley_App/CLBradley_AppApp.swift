//
//  CLBradley_AppApp.swift
//  CLBradley_App
//
//  Created by Cory Bradley on 3/16/26.
//

import SwiftUI
import CoreText

@main
struct CLBradley_AppApp: App {

    init() {
        registerFonts()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    private func registerFonts() {
        guard let url = Bundle.main.url(forResource: "CLBRADLEY", withExtension: "ttf") else {
            print("❌ CLBRADLEY.ttf not found in bundle — check Target Membership in Xcode")
            return
        }
        var error: Unmanaged<CFError>?
        CTFontManagerRegisterFontsForURL(url as CFURL, .process, &error)
        if let error = error {
            print("❌ Font registration failed: \(error.takeUnretainedValue())")
        } else {
            print("✅ CLBRADLEY font registered successfully")
        }
    }
}
