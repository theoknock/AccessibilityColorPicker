import SwiftUI
import Charts

struct Intensity: Identifiable {
    var position: Int
    var value: Double
    var id = UUID()
}


struct LayoutPlayground: View {
    @State private var selectedRectangle: Int? = nil  // State to track the selected rectangle
    @State var baseColor: BaseColor
    
   
    //    var numbers = Array(1...12)
    //    let step: Double = (0.94 - 0.06) / 11
    //    var normalizedNumbers = (0..<12).map { 0.06 + Double($0) * step }
    
    
    let positions = Array(0...11)
    let step: Double = (1.0 - 0.00) / 11
    var values: [Double]  { return (0..<11).map { Double($0) * step } }
    var intensities: [Intensity] {
        zip(positions, values).map { Intensity(position: $0, value: $1) }
    }
    
    var body: some View {
        TabView {
            ForEach(0..<3, id: \.self) { mode in
                VStack {
                    HStack(spacing: 6) {
                        ForEach(1...12, id: \.self) { index in
                            VStack(alignment: .center, spacing: 0) {
                                intensityView(index: index, mode: mode, count: 12)
                            }
                        }
                    }
                    .padding()
                    Chart {
                        ForEach(intensities) { intensity in
                            
                            PointMark(
                                x: .value("\(intensity.position)", intensity.position),
                                y: .value("\(intensity.value)", intensity.value)
                                //                                width: 30.0,
                                //                                height: 30.0
                            )
                        }
                    }
                    
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic)) // Enables paging
        .frame(width: UIScreen.main.bounds.width) // Set a fixed height or adjust as needed
    }
    
    @ViewBuilder
    private func intensityView(index: Int, mode: Int, count: Int) -> some View {
        ZStack {
            UnevenRoundedRectangle(topLeadingRadius: 3, bottomLeadingRadius: 3, bottomTrailingRadius: 3, topTrailingRadius: 3)
                .aspectRatio(1.0, contentMode: .fit)
                .scaleEffect(selectedRectangle == index ? 3 : 1)  // Scale up if selected
                .animation(.default, value: selectedRectangle)  // Animate the scaling
                .onTapGesture {
                    self.selectedRectangle = index  // Set the selected rectangle on tap
                }
                .gesture(
                    DragGesture(minimumDistance: 0)  // Drag gesture with zero minimum distance
                        .onChanged { _ in self.selectedRectangle = index }
                )
                .foregroundStyle(baseColor.backgroundColorForIndex(index, mode: mode, count: 12))
        }
    }
    
    
    // Assuming there is a method to get the background color for a given index
//    private func backgroundColorForIndex(_ index: Int, mode: Int, count: Int) -> Color {
//        let h: CGFloat = baseColor.hue
//        let s: CGFloat = 1.0 //colors.scale(oldMin: 0.0, oldMax: 1.0, value: (CGFloat(Double(index) / Double(count))), newMin: 0.125, newMax: 0.857)
//        let b: CGFloat = (1.0 - (CGFloat(Double(index) / Double(count)))) //colors.scale(oldMin: 1.0, oldMax: 0.0, value: (CGFloat(Double(index) / Double(count))), newMin: 0.125, newMax: 0.875)
//       
//        let finalHSLColor = Color(uiColor: UIColor(hue: h, saturation: s, brightness: b, alpha: 1.0))
//        
//        return finalHSLColor
//    }
    
}

struct LayoutPlayground_Previews: PreviewProvider {
    static var previews: some View {
        LayoutPlayground(baseColor: BaseColor()) // Replace Colors() with your actual data structure or data
    }
}

// Assuming the definition for UnevenRoundedRectangle is available
struct UnevenRoundedRectangle: Shape {
    var topLeadingRadius: CGFloat
    var bottomLeadingRadius: CGFloat
    var bottomTrailingRadius: CGFloat
    var topTrailingRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // Custom path drawing using the different corner radii
        path.addRoundedRect(in: rect, cornerRadii: RectangleCornerRadii.init(topLeading: 3.0, bottomLeading: 3.0, bottomTrailing: 3.0, topTrailing: 3.0))     //(in: rect, topLeftRadius: topLeadingRadius, topRightRadius: topTrailingRadius, bottomLeftRadius: bottomLeadingRadius, bottomRightRadius: bottomTrailingRadius)
        return path
    }
    
    private func addRoundedRect(in rect: CGRect, topLeftRadius: CGFloat, topRightRadius: CGFloat, bottomLeftRadius: CGFloat, bottomRightRadius: CGFloat) {
        // Implementation for drawing rounded rectangle with different corner radii
    }
}
