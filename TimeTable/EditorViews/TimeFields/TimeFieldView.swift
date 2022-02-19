//
//  TimeFieldView.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 25.12.21.
//

import SwiftUI

struct TimeFieldView: View {
    let startTime: String
    let endTime: String
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ZStack {
                Rectangle().opacity(EditorDrawingConstants.opacityForGrays)
                Rectangle().stroke(lineWidth: EditorDrawingConstants.middleLineWidth)
                VStack {
                    Text(startTime).font(DrawingConstants.font(for: size))
                    Text("–").font(DrawingConstants.font(for: size))
                    Text(endTime).font(DrawingConstants.font(for: size))
                }
            }
        }
    }
    
    init(for slot: Slot) {
        startTime = slot.start
        endTime = slot.end
    }
    
    
    
    // MARK: - drawing constants
    
    private struct DrawingConstants {
    
        static func font(for size: CGSize) -> Font {
            Font.system(size: min(size.width, size.height/3) * 0.4)
        }
    }
}
