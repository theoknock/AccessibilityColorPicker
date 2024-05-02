//
//  ContentView.swift
//  HueCustomControl
//
//  Created by Xcode Developer on 5/2/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HueControlView()
    }
}

struct HueControlView: View {
    @State var hueAngle: CGFloat = 0.0
    @State var angleValue: CGFloat = 0.0
    
    let minimumValue: CGFloat = 0.0
    let maximumValue: CGFloat = 360.0
    let totalValue: CGFloat = 360.0
    
    private var _knobRadius: CGFloat = 30.0
    var knobRadius: CGFloat {
        get { return _knobRadius }
        set { _knobRadius = newValue }
    }
    
    private var _diameter: CGSize = CGSize(width: (UIScreen.main.bounds.maxX - 15.0) - (UIScreen.main.bounds.minX + 15.0), height: (UIScreen.main.bounds.maxY - 15.0) - (UIScreen.main.bounds.minY + 15.0))
    var diameter: CGSize {
        get { return _diameter }
        set { _diameter = newValue }
    }
    
    private var _radius: CGFloat = UIScreen.main.bounds.midX - UIScreen.main.bounds.minX
    var radius: CGFloat { 
        get { return _radius - (_knobRadius * 1) }
        set { _radius = newValue }
    }
    
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
            Circle()
                .strokeBorder(
                    AngularGradient(gradient: .init(colors: hueColors()), center: .center),
                    lineWidth: knobRadius
                )
                .frame(width: diameter.width, height: diameter.height)
                .contentShape(Circle())
                .rotationEffect(.degrees(-90))
            
            Capsule()
                .fill(Color(hue: Double(hueAngle) / 360.0, saturation: 1.5, brightness: 1.5))
                    .frame(width: knobRadius, height: knobRadius * 2)
                    .padding(EdgeInsets(top: 7.5, leading: 15.0, bottom: 7.5, trailing: 15.0))
                    .offset(y: -radius)
                    .rotationEffect(Angle.degrees(Double(angleValue)))
                    .gesture(DragGesture(minimumDistance: 0.0)
                        .onChanged({ value in
                            change(location: value.location)
                            feedbackGenerator.impactOccurred()
                        }))
                    .shadow(color: Color(hue: Double(hueAngle) / 360.0, saturation: 0.5, brightness: 0.5), radius: 7.5)
                    
                Text("\(String.init(format: "%.0f", hueAngle))º")
                    .font(.largeTitle).dynamicTypeSize(.xLarge)
                    .foregroundStyle(Color(hue: Double(hueAngle) / 360.0, saturation: 1.0, brightness: 1.0))
        })
    }
    
    func hueColors() -> [Color] {
        (0...360).map { i in
            Color(hue: Double(i) / 360.0, saturation: 1.0, brightness: 1.0)
        }
    }
    
    private func change(location: CGPoint) {
        // creating vector from location point
        let vector = CGVector(dx: location.x, dy: location.y)
        
        // geting angle in radian need to subtract the knob radius and padding from the dy and dx
        let angle = atan2(vector.dy - (knobRadius + 15), vector.dx - (knobRadius + 15)) + .pi/2.0
        
        // convert angle range from (-pi to pi) to (0 to 2pi)
        let fixedAngle = angle < 0.0 ? angle + 2.0 * .pi : angle
        // convert angle value to temperature value
        let value = fixedAngle / (2.0 * .pi) * totalValue
        
        if value >= minimumValue && value <= maximumValue {
            hueAngle = value
            angleValue = fixedAngle * 180 / .pi // converting to degree
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
