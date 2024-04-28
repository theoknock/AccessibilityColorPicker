//
//  ObservedColorValuesView.swift
//  AccessibilityColorPicker
//
//  Created by Xcode Developer on 4/26/24.
//

import SwiftUI
import Combine
import Observation


struct ObservedColorValuesView: View {
    @Bindable var colors: ObservableColorValues
    
    var body: some View {
        VStack(alignment: .leading, content: {
            Group {
                Text("H \(String(format: "%.2f", colors.hue))")
                Text("S \(String(format: "%.2f", colors.saturation))")
                Text("B \(String(format: "%.2f", colors.brightness))")
//                Text("A \(String(format: "%.2f", colors.alpha))")
            }
        })
    }
}

//#Preview {
//    ObservedColorValuesView()
//}
