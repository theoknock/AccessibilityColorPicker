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
    
    
    func interpolateHSBColor(from color1: UIColor, to color2: UIColor, fraction: CGFloat) -> UIColor {
        var h1: CGFloat = 0, s1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var h2: CGFloat = 0, s2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
        
        color1.getHue(&h1, saturation: &s1, brightness: &b1, alpha: &a1)
        color2.getHue(&h2, saturation: &s2, brightness: &b2, alpha: &a2)
        
        let hue = h1 + (h2 - h1) * fraction
        let saturation = s1 + (s2 - s1) * fraction
        let brightness = b1 + (b2 - b1) * fraction
        let alpha = a1 + (a2 - a1) * fraction
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }

    func generateHSBColorSwatch(baseColor: UIColor, darkColor: UIColor, lightColor: UIColor) -> [UIColor] {
        var colors = [UIColor]()
        
        // Generate dark/desaturated colors
        for i in stride(from: 6, to: 0, by: -1) {
            let fraction = CGFloat(i) / 6.0
            colors.insert(interpolateHSBColor(from: darkColor, to: baseColor, fraction: fraction), at: 0)
        }
        
        // Insert base color in the middle
        colors.append(baseColor)
        
        // Generate light/saturated colors
        for i in stride(from: 1, through: 6, by: 1) {
            let fraction = CGFloat(i) / 6.0
            colors.append(interpolateHSBColor(from: baseColor, to: lightColor, fraction: fraction))
        }
        
        return colors
    }

}
