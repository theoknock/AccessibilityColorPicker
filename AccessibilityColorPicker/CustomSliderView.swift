//
//  CustomSliderView.swift
//  AccessibilityColorPicker
//
//  Created by Xcode Developer on 4/26/24.
//

import SwiftUI
import UIKit

struct CustomUISlider: UIViewRepresentable {
    @Binding var value: Double
    var range: ClosedRange<Double>

    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.minimumTrackTintColor = UIColor.clear
        slider.maximumTrackTintColor = UIColor.clear
        slider.minimumValue = Float(range.lowerBound)
        slider.maximumValue = Float(range.upperBound)
        slider.value = Float(value)
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
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: CustomUISlider

        init(_ parent: CustomUISlider) {
            self.parent = parent
        }

        @objc func valueChanged(_ sender: UISlider) {
            parent.value = Double(sender.value)
        }
    }
}

struct CustomSliderView: View {
    @Bindable private var colors: Colors
    
    init(colors: Colors) {
        self.colors = colors
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(LinearGradient(gradient: Gradient(colors: [.yellow, .blue]), startPoint: .leading, endPoint: .trailing))
                .frame(height: 30)

            CustomUISlider(value: $colors.hue, range: 135 ... 405)
        }
        .frame(height: 30)
        .padding(.horizontal)
    }
}
