//
//  AccessibilityColorPickerApp.swift
//  AccessibilityColorPicker
//
//  Created by Xcode Developer on 4/25/24.
//

import SwiftUI
import Observation
import Combine

@main
struct AccessibilityColorPickerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(colors: ObservableColorValues())
        }
    }
}
