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
        Coordinator(ObservableColorValueSliderView(value: $value))
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
//    @Bindable var colors: ObservableColorValues
    @Binding var value: Double

//    init(value: Double) {
//        self.value = value
//    }
    
    var body: some View {
        Slider(value: $value, in: 0.0 ... 1.0)
    }
}
