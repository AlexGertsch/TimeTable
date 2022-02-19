//
//  Labelify.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 25.12.21.
//

import SwiftUI

struct Labelify: ViewModifier {
    let fontScaleFactor: CGFloat
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            let scale = min(geometry.size.width, geometry.size.height)
            ZStack {
                Rectangle().opacity(EditorDrawingConstants.opacityForGrays)
                Rectangle().stroke(lineWidth: EditorDrawingConstants.middleLineWidth)
                content.font(Font.system(size: scale * fontScaleFactor))
            }
        }
    }
    
    init(with fontScaleFactor: CGFloat) {
        self.fontScaleFactor = fontScaleFactor
    }
    
    init() {
        fontScaleFactor = 0.8
    }
}

extension View {
    func labelify() -> some View {
        return self.modifier(Labelify())
    }
    
    func labelify(with fontScaleFactor: CGFloat) -> some View {
        return self.modifier(Labelify(with: fontScaleFactor))
    }
}
