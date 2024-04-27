import SwiftUI
import UIKit
import Observation

// Extend UIColor to include a method for inverting colors
extension UIColor {
    func inverted() -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Calculate inverted colors
        //        red = 1.0 - red
        //        green = 1.0 - green
        blue = 1.0 - blue
        
        return UIColor(hue: red, saturation: green, brightness: blue, alpha: 1.0) //UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

struct ContentViewOld: View {
    @State private var baseColor: Color = Color(uiColor: .systemBlue)
    @State private var backColor: Color = Color(uiColor: .systemTeal)
    @State private var foreColor: Color = Color(uiColor: .systemTeal)
    
    var body: some View {
        HStack {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .center), content: {
                RoundedRectangle(cornerRadius: 25)
                    .fill(backColor)
//                    .frame(width: UIScreen.main.bounds.size.width * 0.6, height: 100)
                
                //                    .onChange(of: backColor) { _ in
                //                        // Invert the base color whenever the background color changes
                //                        let uiColor = UIColor(backColor)
                //                        let invertedUIColor = uiColor.inverted()
                //                        baseColor = Color(uiColor: invertedUIColor)
                //                    }
                
                ColorPicker("", selection: $baseColor)
                    .padding(.trailing)
                
                VStack(alignment: .leading, content: {
                    Text("Base")
                        .foregroundColor(foreColor)
                        
                }).padding(.leading)
            })
            
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                RoundedRectangle(cornerRadius: 25)
                    .fill(baseColor)
//                    .frame(width: UIScreen.main.bounds.size.width * 0.375, height: 100)
                
                ColorPicker("", selection: $baseColor)
                    .padding(.trailing)
                
                VStack(alignment: .leading, content: {
                    Text("Accessibility Color")
                        .foregroundColor(foreColor)
                        .padding(.leading)
                })
            })
        }.padding(.trailing)
        
    }
}


//import SwiftUI
//import UIKit
//import Observation
//
//struct ContentView: View {
//    @State private var baseColor: Color = Color(uiColor: .systemBlue)
//    @State private var bkgdColor: Color = Color(uiColor: .systemTeal)
//    @State private var foreColor: Color = Color(uiColor: .systemCyan)
//
//    var body: some View {
//        VStack {
//            ZStack {
//                RoundedRectangle(cornerSize: CGSize(width: 10, height:10))
//                    .padding(.horizontal)
//                    .frame(width: UIScreen.main.bounds.width, height: 100)
//                    .background(bkgdColor)
//                    .overlay {
//                        ColorPicker("", selection: $bkgdColor)
//                            .padding()
//                            .padding()
//                    }
//            }
//            .overlay {
//                Text(colorDescription(color: foreColor))
//                    .multilineTextAlignment(.center)
////                    .foregroundColor(foreColor)
//            }
//        }
//    }
//
//    private func invertColor(color: Color) -> () {
////        foreColor = bkgdColor
//    }
//
//    private func colorDescription(color: Color) -> String {
//        let uiColorDescription = UIColor(foreColor).description
//        return uiColorDescription
//    }
//}
//
//@Observable class ColorCalculator {
//    @private var foreColor: Color
//
//    foreColor =
//}
//
// Preview
struct ContentViewOld_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewOld()
    }
}
