//
//  SwiftUIView.swift
//  AccessibilityColorPicker
//
//  Created by Xcode Developer on 4/30/24.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15.0)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
            .preferredColorScheme(.dark)
    }
}

