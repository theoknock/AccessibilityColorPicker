//
//  ContentViewNew.swift
//  AccessibilityColorPicker
//
//  Created by Xcode Developer on 4/27/24.
//

import SwiftUI
//import Charts
//
//struct Intensity: Identifiable {
//    var position: Int
//    var value: Double
//    var id = UUID()
//}

struct ContentView: View {
    @State var colors: ObservableColorValues = ObservableColorValues()
    var intensity: [String] = ["25","50","100","200","300","400", "500","600","700","800","900","950"]
    
    let images = [
        UIImage(systemName: "h.circle") ?? UIImage(),
        UIImage(systemName: "h.circle.fill") ?? UIImage()
    ]
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 30.0)
                .foregroundStyle(colors.baseColorModel.hsbColor)
                .overlay {
                    Text(hslToHex(hsl: colors.baseColorModel.hsbColor))
                        .font(.largeTitle).dynamicTypeSize(DynamicTypeSize.xxxLarge).bold().foregroundStyle(.regularMaterial)
                }
            
            Group {
                ForEach(0..<3, id: \.self) { mode in
                    ObservableColorValueSliderView(colors: colors,
                                                   value:
                                                    (mode == 0) ? $colors.baseColorModel.hue :
                                                    (mode == 1) ? $colors.baseColorModel.saturation :
                                                    $colors.baseColorModel.brightness,
                                                   mode: mode,
                                                   images: images)
                }
            }
            
            LayoutPlayground(colors: colors)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 30.0)
                .foregroundStyle(.white).opacity(0.1)
                .foregroundStyle(.regularMaterial)
            
        }
        
    }
    
    
    
    //        VStack {
    //            ForEach(0..<3, id: \.self) { mode in
    //                GeometryReader { geometry in
    //                    HStack(spacing: 6) {
    //                        ForEach(0..<$colors.swatchCount.wrappedValue, id: \.self) { index in
    //                            VStack(alignment: .center, spacing: 0, content: {
    //                                ZStack {
    //                                    //                                    UnevenRoundedRectangle(topLeadingRadius: 3, bottomLeadingRadius: 3, bottomTrailingRadius: 3, topTrailingRadius: 3)
    //                                    //                                        .foregroundStyle(backgroundColorForIndex(index, mode: mode, count: colors.swatchCount))     // intensityView(index: index, mode: mode, count: colors.swatchCount)
    //                                }
    //                                .aspectRatio(1.0, contentMode: .fit)
    //
    //                            })
    //                        }
    //                    }
    //                    .padding() // Adds horizontal padding
    //                }
    //            }
    //        }
    
    
    /*
     
     
     Secondary Color: mixing two primary colors of a given color model in even proportions.
     
     Intermediate Color: mixture of a secondary and a primary color.
     
     Tertiary color:
     -  an even mixture between two secondary colors, i.e. a mixture of three primaries in 1:2:1 proportion. This definition is used by color theorists, such as Moses Harris[1] and Josef Albers.[2] The result is approximately a less saturated form of the dominant primary color of the mixture. Under this definition, a color model has 3 tertiary colors.
     -  an even mixture of a primary and a secondary color, i.e. a mixture of the primaries in 3:1:0 proportion. The result yields a maximum saturation for a given hue. Under this definition, a color model has 6 tertiary colors.
     
     */
    
    
    @ViewBuilder
    private func intensityView(index: Int, mode: Int, count: Int) -> some View {
        
        
        ZStack {
            UnevenRoundedRectangle(topLeadingRadius: 3, bottomLeadingRadius: 3, bottomTrailingRadius: 3, topTrailingRadius: 3)
                .foregroundStyle(backgroundColorForIndex(index, mode: mode, count: count))
        }
        .aspectRatio(1.0, contentMode: .fit)
        
        //        ZStack {
        //            UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 3, bottomTrailingRadius: 3, topTrailingRadius: 0)
        //                .foregroundStyle(.white)
        //        }
        //        .aspectRatio(0.5, contentMode: .fit)
        
        //        .frame(width: UIScreen.main.bounds.width * 0.12)
        //        .padding()
    }
    
    private func hslToHex(hsl: Color) -> String {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
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
    
    
    private func backgroundColorForIndex(_ index: Int, mode: Int, count: Int) -> Color {
        
        //        let h: CGFloat = colors.baseColorModel.hue
        //        let s: CGFloat = (mode == 1) ? min(max(colors.baseColorModel.saturation * 0.5, 0.0 + (CGFloat(Double(index) / Double(count)))), colors.baseColorModel.saturation) : colors.baseColorModel.saturation
        //        let b: CGFloat = (mode == 2) ? colors.baseColorModel.brightness * (1.0 - (CGFloat(Double(index) / Double(count)))) : colors.baseColorModel.brightness
        
        let h: CGFloat = colors.baseColorModel.hue
        let s: CGFloat = 1.0 //colors.scale(oldMin: 0.0, oldMax: 1.0, value: (CGFloat(Double(index) / Double(count))), newMin: 0.125, newMax: 0.857)
        let b: CGFloat = colors.scale(oldMin: 1.0, oldMax: 0.0, value: 1.0 - (CGFloat(Double(index) / Double(count))), newMin: 0.0, newMax: 1.0)
        //
        
        let finalHSLColor = Color(uiColor: UIColor(hue: h, saturation: s, brightness: b, alpha: 1.0))
        
        
        //
        //
        //        var hue: CGFloat = 0
        //        var saturation: CGFloat = 0
        //        var brightness: CGFloat = 0
        //        var alpha: CGFloat = 0
        //
        //        (UIColor(colors.baseColorModel.hsbColor)).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        //
        //        let hslColor = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
        //        let components = hslColor.cgColor.components!
        //
        //
        //        //        print("\(mode)")
        //        //        print("\(index) / \(count): \(hue), \(saturation), \(brightness), \(alpha)\t\t\t\t\(CGFloat(index / count))")
        //
        //
        //        let h: CGFloat = hue
        //        let s: CGFloat = saturation //colors.scale(oldMin: 0.0, oldMax: 1.0, value: (CGFloat(Double(index) / Double(count))), newMin: 0.125, newMax: 0.857)
        //        let b: CGFloat = brightness * (-1.0 + (CGFloat(Double(index) / Double(count)))) //colors.scale(oldMin: 1.0, oldMax: 0.0, value: (CGFloat(Double(index) / Double(count))), newMin: 0.125, newMax: 0.875)
        //
        //        let finalHSLColor = Color(uiColor: UIColor(hue: h, saturation: s, brightness: b, alpha: 1.0))
        //
        //
        //        //        let returnedColor = Color(uiColor: finalHSLColor)
        //        //        print("\(index): \(h), \(s), \(b), \(alpha)\t\t\t\t\(CGFloat(index / count))\n")
        //
        
        return finalHSLColor
    }
    
    private func textColorForIndex(_ index: Int, mode: Int, count: Int) -> Color {
        
        let h: CGFloat = colors.baseColorModel.hue
        let s: CGFloat = 1.0 // colors.baseColorModel.saturation //colors.scale(oldMin: 0.0, oldMax: 1.0, value: (CGFloat(Double(index) / Double(count))), newMin: 0.125, newMax: 0.857)
        let b: CGFloat = 1.0 // colors.baseColorModel.brightness * (1.0 - (CGFloat(Double(index + 1) / Double(count) * 2.0))) //colors.scale(oldMin: 1.0, oldMax: 0.0, value: (CGFloat(Double(index) / Double(count))), newMin: 0.125, newMax: 0.875)
        //
        
        let finalHSLColor = Color(hue: h, saturation: s, brightness: b, opacity: (CGFloat(Double(index) / Double(count))))
        
        return finalHSLColor
        
        //        let baseColor = UIColor(colors.baseColorModel.hsbColor)
        //        var hue: CGFloat = 0
        //        var saturation: CGFloat = 0
        //        var brightness: CGFloat = 0
        //        var alpha: CGFloat = 0
        //        baseColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        //
        //        // Normalize the index to a value between 0 and 1
        //        let normalizedIndex = CGFloat(index) / CGFloat(count)
        //        let progressFore = normalizedIndex * 2
        //        let progressAft = (1.0 - normalizedIndex) * 2
        //
        //        // Calculate the transition
        //        var newColor: Color = Color(hue: hue, saturation: (saturation * progressAft) * saturation, brightness: (brightness - progressFore) * brightness, opacity: 1.0)
        ////        if normalizedIndex < 0.5 {
        ////            // Transition from white to the original color
        ////            let progress = normalizedIndex * 2 // Scale factor for the first half
        ////            newColor = Color(hue: hue, saturation: saturation * progress, brightness: brightness + (1 - brightness) * (1 - progress), opacity: alpha)
        ////        } else {
        ////            // Transition from the original color to black
        ////            let progress = (normalizedIndex - 0.5) * 2 // Scale factor for the second half
        ////            newColor = Color(hue: hue, saturation: saturation * (1 - progress), brightness: brightness * (1 - progress), opacity: alpha)
        ////        }
        //
        //        return newColor
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView(colors: ObservableColorValues())
                .preferredColorScheme(.dark)
        }
    }
    
