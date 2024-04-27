//
//  ContentView.swift
//  AccessibilityColorPicker
//
//  Created by Xcode Developer on 4/25/24.
//

import SwiftUI
import UIKit
import Observation

struct ContentView: View {
    @State private var colors = ObservableColorValues()
    //    @State private var baseColor: Color = Color(uiColor: .systemBlue)
    var intensity: [String] = ["25","50","100","200","300","400", "500","600","700","800","900","950"]
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [
                            Color(UIColor(hue: 0.0, saturation: 1.0, brightness: 1.0, alpha: 1.0)),
                            Color(UIColor(hue: 0.333, saturation: 1.0, brightness: 1.0, alpha: 1.0)),
                            Color(UIColor(hue: 0.667, saturation: 1.0, brightness: 1.0, alpha: 1.0)),
                            Color(UIColor(hue: 1.0, saturation: 1.0, brightness: 1.0, alpha: 1.0))
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 30)
                
                ObservableColorValueSliderView(value: $colors.hue)
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [
                            Color(UIColor(hue: colors.hue, saturation: 0.0, brightness: colors.brightness, alpha: 1.0)),
                            Color(UIColor(hue: colors.hue, saturation: 1.0, brightness: colors.brightness, alpha: 1.0))
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 30)
                
                ObservableColorValueSliderView(value: $colors.saturation)
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [
                            Color(UIColor(hue: colors.hue, saturation: colors.saturation, brightness: 0.0, alpha: 1.0)),
                            Color(UIColor(hue: colors.hue, saturation: colors.saturation, brightness: 1.0, alpha: 1.0))
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 30)
                
                ObservableColorValueSliderView(value: $colors.brightness)
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(colors.baseColor)
                    .frame(width: UIScreen.main.bounds.size.width / 12, height: UIScreen.main.bounds.size.height / 12)
            }.frame(width: UIScreen.main.bounds.size.width / 6, height: UIScreen.main.bounds.size.height / 6)
        }
        
        Group {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<intensity.count, id: \.self) { index in
                        intensityView(index: index)
                            .frame(width: UIScreen.main.bounds.size.width / 12, height: UIScreen.main.bounds.size.height / 12)
                    }
                }
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<intensity.count, id: \.self) { index in
                        intensityView(index: index)
                            .frame(width: UIScreen.main.bounds.size.width / 12, height: UIScreen.main.bounds.size.height / 12)
                    }
                }
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<intensity.count, id: \.self) { index in
                        intensityView(index: index)
                            .frame(width: UIScreen.main.bounds.size.width / 12, height: UIScreen.main.bounds.size.height / 12)
                    }
                }
            }
        }.frame(maxWidth: UIScreen.main.bounds.size.width, maxHeight: (UIScreen.main.bounds.size.height / 2))
        
        //            ScrollView(.vertical, content: {
        //                VStack {
        //                    ForEach(0..<12) { index in
        //                        ZStack {
        //                            RoundedRectangle(cornerRadius: 12.0)
        //                                .frame(width: UIScreen.main.bounds.size.width / 12, height: UIScreen.main.bounds.size.width / 12)
        //                                .foregroundColor(baseColor).opacity(Double(index) * (1/12) + (1/12))
        //                            Text("\(intensity[index])")
        //                                .foregroundColor(baseColor) // Ensure baseColor is defined elsewhere as a Color
        //                                .opacity(1.0 - (Double(index) * (1.0 / 12) + (1.0 / 12)))
        //                        }
        //                    }
        //                }.safeAreaPadding()
        //            })
        //            .frame(height: UIScreen.main.bounds.size.height)
        //            .safeAreaPadding()
    }
    
    
    @ViewBuilder
    private func intensityView(index: Int) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12.0)
                .foregroundColor(backgroundColorForIndex(12-index))
            VStack {
                //            Text(String("\(index)")
                //                .foregroundColor(textColorForIndex(index))
                Text(hslToHex(hsl: textColorForIndex(index)))
                    .foregroundColor(textColorForIndex(index))
            }.frame(width: UIScreen.main.bounds.size.width / 12, height: UIScreen.main.bounds.size.width / 12)
        }
    }
    
    private func hslToHex(hsl: Color) -> String {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        // Extracts hue, saturation, brightness, and alpha values from the UIColor object
        (UIColor(hsl)).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        // Generate RGB values from HSB
        let rgbColor = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
        let components = rgbColor.cgColor.components!
        let r: Int = Int(components[0] * 255)
        let g: Int = Int(components[1] * 255)
        let b: Int = Int(components[2] * 255)
        
        // Generate hexadecimal color string using RGB values
        let hexColor = String(format: "#%02X%02X%02X", r, g, b)
        
        // Return the hexadecimal color string
        return hexColor
    }
    
    
    private func backgroundColorForIndex(_ index: Int) -> Color {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        var newColor: Color
        
        (UIColor(colors.baseColor)).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        newColor = Color.init(uiColor: UIColor(hue: hue, saturation: saturation, brightness: pow(brightness * (Double(index) / 12), (1.0/brightness)), alpha: alpha))
        return newColor
    }
    
    private func textColorForIndex(_ index: Int) -> Color {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        var newColor: Color
        
        //        let newIndex: Int = {
        //            switch index {
        //            case 5:
        //                return 0
        //            case 6:
        //                return 1
        //            case 7:
        //                return 11
        //            default:
        //                return index
        //            }
        //        }()
        
        (UIColor(colors.baseColor)).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        newColor = Color.init(uiColor: UIColor(hue: hue, saturation: saturation, brightness: (brightness + (Double(12 - index) / 12)), alpha: alpha))
        return newColor
    }
}

#Preview {
    ContentView()
}
