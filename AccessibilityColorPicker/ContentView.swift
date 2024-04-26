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
    @State private var baseColor: Color = Color(uiColor: .systemBlue)
    var intensity: [String] = ["25","50","100","200","300","400", "500","600","700","800","900","950"]
    
    
    
    var body: some View {
        
        VStack {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(baseColor)
                    .frame(height: UIScreen.main.bounds.size.height * 0.333)
                //            .safeAreaPadding()
                
                ColorPicker("", selection: $baseColor).padding(.trailing)
                    .padding(.vertical)
            })
            .safeAreaPadding()
            ScrollView {
                ForEach(0..<intensity.count, id: \.self) { index in
                    intensityView(index: index)
                }.frame(height: UIScreen.main.bounds.size.height).safeAreaPadding()
            }.padding(.vertical)
                
                    ScrollView {
                        ForEach(0..<intensity.count, id: \.self) { index in
                            intensityView(index: index)
                        }.frame(height: UIScreen.main.bounds.size.height).safeAreaPadding()
                    }.padding(.vertical)
                
                    ScrollView {
                        ForEach(0..<intensity.count, id: \.self) { index in
                            intensityView(index: index)
                        }.frame(height: UIScreen.main.bounds.size.height).safeAreaPadding()
                    }.padding(.vertical)
            
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
    }
    @ViewBuilder
    private func intensityView(index: Int) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12.0)
                .foregroundColor(backgroundColorForIndex(12-index))
            VStack {
                Text(intensity[index])
                    .foregroundColor(textColorForIndex(index))
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
        
        (UIColor(baseColor)).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        newColor = Color.init(uiColor: UIColor(hue: hue, saturation: saturation, brightness: pow(brightness * (Double(index) / 12), (1.0/brightness)), alpha: alpha))
        return newColor
    }
    
    
    private func textColorForIndex(_ index: Int) -> Color {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        var newColor: Color
        
        let newIndex: Int = {
            switch index {
            case 5:
                return 0
            case 6:
                return 1
            case 7:
                return 11
            default:
                return index
            }
        }()
        
        (UIColor(baseColor)).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        newColor = Color.init(uiColor: UIColor(hue: hue, saturation: saturation, brightness: (brightness + (Double(12 - index) / 12)), alpha: alpha))
        return newColor
    }
}

#Preview {
    ContentView()
}
