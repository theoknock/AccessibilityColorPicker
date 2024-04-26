//
//  AccessibilityColorPickerApp.swift
//  AccessibilityColorPicker
//
//  Created by Xcode Developer on 4/25/24.
//

import SwiftUI

class SharedViewModel: ObservableObject {
    @Published var baseColor: Color = Color(uiColor: .systemTeal)
}

@main
struct AccessibilityColorPickerApp: App {
    var viewModel = SharedViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
