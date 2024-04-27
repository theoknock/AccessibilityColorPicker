//
//  ObservedColorValuesView.swift
//  AccessibilityColorPicker
//
//  Created by Xcode Developer on 4/26/24.
//

import SwiftUI


struct ObservedColorValuesView: View {
    @State private var colors = ObservableColorValues()
    
    var body: some View {
        VStack {
            Text("ObservedColorValuesView.colors.hue = \(colors.hue)")
            Text("ObservedColorValuesView.colors.saturation = \(colors.saturation)")
            Text("ObservedColorValuesView.colors.brightness = \(colors.brightness)")
            ObservableColorValueSliderView(value: $colors.hue)
        }
    }
}

#Preview {
    ObservedColorValuesView()
}
