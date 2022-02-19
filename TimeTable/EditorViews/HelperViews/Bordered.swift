//
//  Bordered.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 25.12.21.
//

import SwiftUI

struct Bordered: ViewModifier {
    let thick: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            Rectangle()
                .stroke(lineWidth: thick ?
                    EditorDrawingConstants.thickLineWidth :
                    EditorDrawingConstants.thinLineWidth)
            content
        }
    }
}

extension View {
    func bordered(thick: Bool) -> some View {
        self.modifier(Bordered(thick: thick))
    }
}
