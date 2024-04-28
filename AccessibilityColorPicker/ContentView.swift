//
//  ContentViewNew.swift
//  AccessibilityColorPicker
//
//  Created by Xcode Developer on 4/27/24.
//

import SwiftUI

struct ContentView: View {
    @State var colors: ObservableColorValues
    var intensity: [String] = ["25","50","100","200","300","400", "500","600","700","800","900","950"]
    
    var body: some View {
        HStack {
            VStack {
                Group {
                    ObservableColorValueSliderView(colors: colors, value: $colors.hue, mode: 0)
                    ObservableColorValueSliderView(colors: colors, value: $colors.saturation, mode: 1)
                    ObservableColorValueSliderView(colors: colors, value: $colors.brightness, mode: 2)
                    ObservableColorValueSliderView(colors: colors, value: $colors.alpha, mode: 3)
                }
            }
            
            VStack {
                ObservedColorValuesView(colors: colors)
            }
        }
        
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 0, content: {
                ForEach(0..<$colors.swatchCount.wrappedValue, id: \.self) { index in
                    intensityView(index: index, mode: 0, count: colors.swatchCount)
                        .scaledToFill()
                }
            })
        }
        
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 0, content: {
                ForEach(0..<$colors.swatchCount.wrappedValue, id: \.self) { index in
                    intensityView(index: index, mode: 1, count: colors.swatchCount)
                        .scaledToFill()
                }
            })
        }
        
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 0, content: {
                ForEach(0..<$colors.swatchCount.wrappedValue, id: \.self) { index in
                    intensityView(index: index, mode: 2, count: colors.swatchCount)
                        .scaledToFill()
                }
            })
        }
        
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 0, content: {
                ForEach(0..<$colors.swatchCount.wrappedValue, id: \.self) { index in
                    intensityView(index: index, mode: 3, count: colors.swatchCount)
                        .scaledToFill()
                }
            })
        }
        
    }
    
    
    /*
     
     
     Secondary Color: mixing two primary colors of a given color model in even proportions.
     
     Intermediate Color: mixture of a secondary and a primary color.
     
     Tertiary color:
     -  an even mixture between two secondary colors, i.e. a mixture of three primaries in 1:2:1 proportion. This definition is used by color theorists, such as Moses Harris[1] and Josef Albers.[2] The result is approximately a less saturated form of the dominant primary color of the mixture. Under this definition, a color model has 3 tertiary colors.
     -  an even mixture of a primary and a secondary color, i.e. a mixture of the primaries in 3:1:0 proportion. The result yields a maximum saturation for a given hue. Under this definition, a color model has 6 tertiary colors.
     
     */
    
    
    @ViewBuilder
    private func intensityView(index: Int, mode: Int, count: Int) -> some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
            UnevenRoundedRectangle(topLeadingRadius: 12, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 12)
                .foregroundColor(backgroundColorForIndex(index, mode: mode, count: count))
                .overlay {
                    Text("\(intensity[index])")
                        .font(.largeTitle)
                        .foregroundColor(textColorForIndex(count - index))
                        .padding(.vertical)
                        .scaledToFill()
                }
            UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 12, bottomTrailingRadius: 12, topTrailingRadius: 0)
                .foregroundColor(.white)
                .overlay {
                    Text(hslToHex(hsl: backgroundColorForIndex(index, mode: mode, count: count)))
                        .font(.footnote)
                        .foregroundColor(textColorForIndex(index))
                        .padding(.vertical)
                }
            
        }).padding()
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
    
    
    private func backgroundColorForIndex(_ index: Int, mode: Int, count: Int) -> Color {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        (UIColor(colors.baseColor)).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        let newColor: Color = {
            switch mode {
            case 0:
                return Color.init(uiColor: UIColor(hue: hue * ((Double(index) / Double(count))), saturation: saturation, brightness: brightness, alpha: (Double(index) / Double(count))))
            case 1:
                return Color.init(uiColor: UIColor(hue: hue, saturation: ((Double(index) / Double(count))), brightness: brightness, alpha: alpha))
            case 2:
                return Color.init(uiColor: UIColor(hue: hue, saturation: saturation, brightness: ((Double(index) / Double(count))), alpha: alpha))
            case 3:
                return Color.init(uiColor: UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: ((Double(index) / Double(count)))))
            default:
                return Color.init(uiColor: UIColor(.accentColor))
            }
        }()
        
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(colors: ObservableColorValues())
            .preferredColorScheme(.dark)
    }
}
