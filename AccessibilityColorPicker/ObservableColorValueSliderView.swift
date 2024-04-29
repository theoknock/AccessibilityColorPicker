//
//  ObservableColorValueSliderView.swift
//  AccessibilityColorPicker
//
//  Created by Xcode Developer on 4/26/24.
//

import SwiftUI
import UIKit

struct ObservableColorValueSliderViewRepresentable: UIViewRepresentable {
    @Binding var value: Double
    var mode: Int
    var colors: ObservableColorValues
    var range: ClosedRange<Double>
    var images: [UIImage]
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.minimumTrackTintColor = UIColor.clear
        slider.maximumTrackTintColor = UIColor.clear
        slider.minimumValue = Float(range.lowerBound)
        slider.maximumValue = Float(range.upperBound)
        slider.value = Float(value)
        slider.minimumValueImage = UIImage(systemName: "h.circle")
        slider.maximumValueImage = UIImage(systemName: "h.circle.fill")
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged(_:)),
            for: .valueChanged
        )
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(ObservableColorValueSliderView(colors: colors, value: $value, mode: mode, images: images))
    }
    
    class Coordinator: NSObject {
        var parent: ObservableColorValueSliderView
        
        init(_ parent: ObservableColorValueSliderView) {
            self.parent = parent
        }
        
        @objc func valueChanged(_ sender: UISlider) {
            parent.value = Double(sender.value)
        }
    }
}

// insert another view here that just produces one slider

struct ObservableColorValueSliderView: View {
    @Bindable var colors: ObservableColorValues
//    @Bindable var hsbComponents: BaseColor = BaseColor()
    
//    @Bindable var hsbColor: Color { baseColor.hsbColor }
    @Binding var value: Double
    var mode: Int
    var images: [UIImage]
    
    
    var body: some View {
        let gradientColors: [[Color]] = [
            
            
            // mode: 0
            [Color(UIColor(hue: 0.0, saturation: 1.0, brightness: 1.0, alpha: 1.0)),
             Color(UIColor(hue: 0.333, saturation: 1.0, brightness: 1.0, alpha: 1.0)),
             Color(UIColor(hue: 0.667, saturation: 1.0, brightness: 1.0, alpha: 1.0)),
             Color(UIColor(hue: 1.0, saturation: 1.0, brightness: 1.0, alpha: 1.0))],
            
            // mode: 1
            [Color(UIColor(hue: colors.baseColorModel.component(index: 0) ?? 0.5722222222, saturation: 0.0, brightness: 1.0, alpha: 1.0)),
             Color(UIColor(hue: colors.baseColorModel.component(index: 0) ?? 0.5722222222, saturation: 1.0, brightness: 1.0, alpha: 1.0))],
            
            // mode: 2
            [Color(UIColor(hue: colors.baseColorModel.component(index: 0) ?? 0.5722222222, saturation: 1.0, brightness: 0.0, alpha: 1.0)),
             Color(UIColor(hue: colors.baseColorModel.component(index: 0) ?? 0.5722222222, saturation: 1.0, brightness: 1.0, alpha: 1.0))],
            
            // mode: 3
            [Color(UIColor(hue: colors.baseColorModel.component(index: 0) ?? 0.5722222222, saturation: 1.0, brightness: 1.0, alpha: 0.0)),
             Color(UIColor(hue: colors.baseColorModel.component(index: 0) ?? 0.5722222222, saturation: 1.0, brightness: 1.0, alpha: 1.0))],

            [Color(UIColor(hue: 0.0, saturation: 1.0, brightness: 1.0, alpha: 1.0)),
             Color(UIColor(hue: 0.333, saturation: 1.0, brightness: 1.0, alpha: 1.0)),
             Color(UIColor(hue: 0.667, saturation: 1.0, brightness: 1.0, alpha: 1.0)),
             Color(UIColor(hue: 1.0, saturation: 1.0, brightness: 1.0, alpha: 1.0))]
        ]
        
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(LinearGradient(
                    gradient: Gradient(colors: gradientColors[mode]),
                    startPoint: .leading,
                    endPoint: .trailing
                )).frame(height: 30)
            
            Slider(value:
                    (mode == 0) ? $colors.baseColorModel.hue :
                    (mode == 1) ? $colors.baseColorModel.saturation :
                    $colors.baseColorModel.brightness,
                   in: 0.0 ... 1.0)
        }
    }
}
