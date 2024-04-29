//
//  LayoutPlayground.swift
//  AccessibilityColorPicker
//
//  Created by Xcode Developer on 4/28/24.
//

import SwiftUI

struct LayoutPlayground: View {
    
    
    var body: some View {
        
        let columnCount: Int = 2
        let gridSpacing: CGFloat = 16.0

        let axes: Axis.Set = [.horizontal]
    

        ScrollView(.horizontal) {
            LazyHGrid(rows: Array(repeating: .init(.fixed(UIScreen.main.bounds.width / 3), spacing: gridSpacing), count: 3), spacing: gridSpacing) {
                //
            }
            .padding(.all, 16)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                
        }.flipsForRightToLeftLayoutDirection(true)
            
        

//        ScrollView(axes, showsIndicators: false) {
//            HStack(spacing: 8.0) {
//                ForEach(0..<12) { item in
//                    RoundedRectangle(cornerRadius: 8.0)
//                        .fill(.tint)
//                        .aspectRatio(1.0, contentMode: .fit)
//                        .containerRelativeFrame(axes, count: 12, span: 1, spacing: 0)
//                }
//            }
//        }
//        
//        ScrollView(.horizontal) {
//            HStack {
//                Group {
//                    Text("element")
//                    Text("element")
//                    Text("element")
//                    Text("element")
//                    Text("element")
//                    Text("element")
//                    Text("element")
//                    Text("element")
//                    Text("element")
//                    Text("element")
//                }
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .frame(maxWidth: .infinity)
//                .padding(.all, 16)
//                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//            }.border(Color.red, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//        }
//        .defaultScrollAnchor(.center)
    }
}

#Preview {
    LayoutPlayground()
}
