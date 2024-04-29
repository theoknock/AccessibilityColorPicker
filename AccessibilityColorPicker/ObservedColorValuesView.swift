//
//  ObservedColorValuesView.swift
//  AccessibilityColorPicker
//
//  Created by Xcode Developer on 4/26/24.
//

import SwiftUI
import Combine
import Observation


struct ObservedColorValuesView: View {
    @Bindable var colors: ObservableColorValues
    
    var body: some View {
        VStack(alignment: .leading, content: {
            Group {
                Text("H \(String(format: "%.2f", colors.baseColorModel.component(index: 0) ?? 0.5722222222))")
                Text("S \(String(format: "%.2f", colors.baseColorModel.component(index: 1) ?? 1.0))")
                Text("B \(String(format: "%.2f", colors.baseColorModel.component(index: 1) ?? 1.0))")
            }
        })
    }
}

//#Preview {
//    ObservedColorValuesView()
//}
