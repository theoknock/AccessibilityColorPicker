//
//  ColorsObservableValues.swift
//  AccessibilityColorPicker
//
//  Created by Xcode Developer on 4/26/24.
//

import Foundation
import SwiftUI
import Combine

@Observable
class ObservableColorValues {
    // Sapphire
    //      HEX  #0091FF
    //      HSL  206, 100, 100
    //      HSL+ 0.5722222222, 1.0, 1.0
    
    var hue: Double        = Double(0.5722222222)
    var saturation: Double = Double(1.0)
    var brightness: Double = Double(1.0)
    var alpha: Double = Double(1.0)
    var swatchCount: Int = 12
    
    var baseColor: Color {
        Color(hue: hue, saturation: saturation, brightness: brightness)
    }
}
