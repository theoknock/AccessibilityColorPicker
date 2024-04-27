//
//  AccessibilityColorPickerApp.swift
//  AccessibilityColorPicker
//
//  Created by Xcode Developer on 4/25/24.
//

import SwiftUI
import Observation
import Combine

@Observable
class Colors {
    var hue: Double = Double(0.5)
    var saturation: Double = Double(1.0)
    var brightness: Double = Double(1.0)
    
    var baseColor: Color {
        Color(hue: hue, saturation: saturation, brightness: brightness)
    }
}


@main
struct AccessibilityColorPickerApp: App {
    @State private var colors = Colors()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
