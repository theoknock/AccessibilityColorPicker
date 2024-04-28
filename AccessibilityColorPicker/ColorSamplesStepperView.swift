//
//  ColorSamplesStepperView.swift
//  AccessibilityColorPicker
//
//  Created by Xcode Developer on 4/28/24.
//

import SwiftUI
import Combine
import Observation

struct ColorSamplesStepperView: View {
    @Binding var swatchCount: Int
    let step = 1
    let range = 1...24

    var body: some View {
        Stepper(
            value: $swatchCount,
            in: range,
            step: step
        ) {
            Text("Current: \(swatchCount) in \(range.description) " +
                 "stepping by \(step)")
        }
        .padding(10)
    }
}
