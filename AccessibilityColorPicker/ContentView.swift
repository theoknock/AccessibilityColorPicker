//
//  ContentViewNew.swift
//  AccessibilityColorPicker
//
//  Created by Xcode Developer on 4/27/24.
//

import SwiftUI
import Charts

struct Intensity: Identifiable {
    var position: Int
    var value: Int
    var id = UUID()
}

struct ContentView: View {
    @State var colors: ObservableColorValues
    var intensity: [String] = ["25","50","100","200","300","400", "500","600","700","800","900","950"]
    
    
    var intensities: [Intensity] = [
        .init(position: 0, value: 25),
        .init(position: 1, value: 50),
        .init(position: 2, value: 100),
        .init(position: 3, value: 200),
        .init(position: 4, value: 300),
        .init(position: 5, value: 400),
        .init(position: 6, value: 500),
        .init(position: 7, value: 600),
        .init(position: 8, value: 700),
        .init(position: 9, value: 800),
        .init(position: 10, value: 900),
        .init(position: 11, value: 950)]
    
    let images = [
        UIImage(systemName: "h.circle") ?? UIImage(),
        UIImage(systemName: "h.circle.fill") ?? UIImage()
    ]
    
    var body: some View {
        HStack {
            Group {
                RoundedRectangle(cornerRadius: 30.0)
                    .foregroundStyle(colors.baseColor)
                    .overlay {
                        Text(hslToHex(hsl: colors.baseColor))
                            .font(.largeTitle).dynamicTypeSize(DynamicTypeSize.xxxLarge).bold()
                            .foregroundStyle(.regularMaterial)
                    }
                ////                            ObservedColorValuesView(colors: colors)
                //                                .font(.largeTitle)
                //                                .foregroundStyle(.regularMaterial)
                //                        }
                VStack {
                    ObservableColorValueSliderView(colors: colors, value: $colors.hue, mode: 0, images: images)
                    Spacer()
                    ObservableColorValueSliderView(colors: colors, value: $colors.saturation, mode: 1, images: images)
                    Spacer()
                    ObservableColorValueSliderView(colors: colors, value: $colors.brightness, mode: 2, images: images)
                    //                    ObservableColorValueSliderView(colors: colors, value: $colors.alpha, mode: 3)
                }
                
                Chart {
                    ForEach(intensities) { intensity in
                        PointMark(
                            x: .value("\(intensity.position)", intensity.position),
                            y: .value("\(intensity.value)", intensity.value)
                        )
                    }
                }
            }.padding()
            
            
            
        }
        .background {
            RoundedRectangle(cornerRadius: 12.0)
                .foregroundStyle(.white).opacity(0.15)
                .foregroundStyle(.regularMaterial)
        }
        
        
        Group {
            ScrollView(.horizontal) {
                HStack(alignment: .center, spacing: 0, content: {
                    ForEach(0..<$colors.swatchCount.wrappedValue, id: \.self) { index in
                        intensityView(index: index, mode: 0, count: colors.swatchCount)
                    }
                })
            }
            ScrollView(.horizontal) {
                HStack(alignment: .center, spacing: 0, content: {
                    ForEach(0..<$colors.swatchCount.wrappedValue, id: \.self) { index in
                        intensityView(index: index, mode: 1, count: colors.swatchCount)
                    }
                })
            }
            
            ScrollView(.horizontal) {
                HStack(alignment: .center, spacing: 0, content: {
                    ForEach(0..<$colors.swatchCount.wrappedValue, id: \.self) { index in
                        intensityView(index: index, mode: 2, count: colors.swatchCount)
                    }
                })
            }
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
                .foregroundStyle(backgroundColorForIndex(index, mode: mode, count: count))
            UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 12, bottomTrailingRadius: 12, topTrailingRadius: 0)
                .foregroundStyle(backgroundColorForIndex(12 - index, mode: mode, count: count))
//                .overlay {
//                    ZStack {
//                        Color(backgroundColorForIndex(index, mode: mode, count: 12))
//                        Text(hslToHex(hsl: colors.baseColor))
//                    }
//                }
//                .overlay {
//                    Text(hslToHex(hsl: backgroundColorForIndex(12 - index, mode: mode, count: count)))
//                        .foregroundColor(textColorForIndex(index))
//                        .padding(.vertical)
//                }
//            UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 12, bottomTrailingRadius: 12, topTrailingRadius: 0)
//                .foregroundColor(.white)
//                .overlay {
//                    Text(hslToHex(hsl: backgroundColorForIndex(12 - index, mode: mode, count: count)))
//                        .foregroundColor(textColorForIndex(index))
//                        .padding(.vertical)
//                }
            
        })
        .frame(width: UIScreen.main.bounds.width * 0.12)
        .padding()
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
        let a: Int = Int(components[3] * 255)
        
        // Generate hexadecimal color string using RGB values
        let hexColor = String(format: "#%02X%02X%02X", r, g, b)
        
        // Return the hexadecimal color string
        return hexColor
    }
    
    
    private func backgroundColorForIndex(_ index: Int, /*colors: ObservableColorValues,*/ mode: Int, count: Int) -> Color {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        (UIColor(colors.baseColor)).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        let hslColor = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
//        print("\(mode)")
//        print("\(index) / \(count): \(hue), \(saturation), \(brightness), \(alpha)\t\t\t\t\(CGFloat(index / count))")
        
        let components = hslColor.cgColor.components!
        
        let h: CGFloat = hue
        let s: CGFloat = (mode == 0 || mode == 1) ? CGFloat(Double(index) / Double(count)) : saturation
        var b: CGFloat = (mode == 0 || mode == 2) ? CGFloat(Double(index) / Double(count)) : brightness
//        let a: CGFloat = 1.0 //colors.alpha
        let finalHSLColor = UIColor(hue: h, saturation: s, brightness: b, alpha: 1.0)
        let returnedColor = Color(uiColor: finalHSLColor)
//        print("\(index): \(h), \(s), \(b), \(alpha)\t\t\t\t\(CGFloat(index / count))\n")
        return returnedColor
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
