//
//  ContentViewNew.swift
//  AccessibilityColorPicker
//
//  Created by Xcode Developer on 4/27/24.
//

import SwiftUI

struct ContentView: View {
    @State private var colors = ObservableColorValues()
    var intensity: [String] = ["25","50","100","200","300","400", "500","600","700","800","900","950"]
    
    
    var body: some View {
        HStack {
            VStack {
                Group {
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
                            )).frame(height: 30)
                        
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
                            )).frame(height: 30)
                        
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
                            )).frame(height: 30)
                        
                        ObservableColorValueSliderView(value: $colors.brightness)
                    }
                }
            }
            VStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(UIColor(hue: colors.hue, saturation: colors.saturation, brightness: colors.brightness, alpha: 1.0)))
                    .frame(width: 30)
            }
            VStack {
                ObservedColorValuesView()
            }
        }
        
        //        ScrollView(.horizontal) {
        //            HStack(alignment: .center, spacing: 0, content: {
        //                ForEach(0..<intensity.count, id: \.self) { index in
        //                    intensityView(index: index, value: 1)
        //                        .scaledToFill()
        //                    //                                                .frame(width: UIScreen.main.bounds.size.width / 12, height: UIScreen.main.bounds.size.height / 12)
        //                    //                                .scaledToFit()
        //                }
        //            })
        //        }
        
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 0, content: {
                ForEach(0..<intensity.count, id: \.self) { index in
                    intensityView(index: index, value: 1)
                        .scaledToFill()
                    //                                                .frame(width: UIScreen.main.bounds.size.width / 12, height: UIScreen.main.bounds.size.height / 12)
                    //                                .scaledToFit()
                }
            })
        }
        
        
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 0, content: {
                ForEach(0..<intensity.count, id: \.self) { index in
                    intensityView(index: index, value: 1)
                        .scaledToFill()
                    //                                                .frame(width: UIScreen.main.bounds.size.width / 12, height: UIScreen.main.bounds.size.height / 12)
                    //                                .scaledToFit()
                }
            })
        }
        
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 0, content: {
                ForEach(0..<intensity.count, id: \.self) { index in
                    intensityView(index: index, value: 1)
                        .scaledToFill()
                    //                                                .frame(width: UIScreen.main.bounds.size.width / 12, height: UIScreen.main.bounds.size.height / 12)
                    //                                .scaledToFit()
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
    private func intensityView(index: Int, value: Int) -> some View {
//        ZStack {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                UnevenRoundedRectangle(topLeadingRadius: 12, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 12)
                    .foregroundColor(backgroundColorForIndex(12-index))
                
                UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 12, bottomTrailingRadius: 12, topTrailingRadius: 0)
                    .foregroundColor(.white)
                    .overlay {
                        Text(hslToHex(hsl: textColorForIndex(index)))
                            .font(.footnote)
                            .foregroundColor(textColorForIndex(index))
//                            .padding(.horizontal)
                            .padding(.vertical)
                        
                    }
                    
            }).padding()
//        }
        
        //                .frame(width: UIScreen.main.bounds.size.height / 12, height: UIScreen.main.bounds.size.width * 0.25 )
        //            VStack {
        //                //            Text(String("\(index)")
        //                //                .foregroundColor(textColorForIndex(index))
        //                Text(hslToHex(hsl: textColorForIndex(index))).scaledToFit()
        //                    .font(.footnote)
        //                    .foregroundColor(textColorForIndex(index))
        //                    .padding(.horizontal)
        ////                    .scaledToFill()
        //            }
        //            .frame(width: UIScreen.main.bounds.size.width / 12, height: UIScreen.main.bounds.size.width / 12)
        
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
            .preferredColorScheme(.dark)
    }
