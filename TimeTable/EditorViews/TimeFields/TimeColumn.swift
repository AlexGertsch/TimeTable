//
//  TimeColumn.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 25.12.21.
//

import SwiftUI

struct TimeColumn: View {
    let position: MainTimeTable.TimeColumnPosition
    
    var body: some View {
        GeometryReader { geometry in
            let dayHeight = geometry.size.height
            let minuteHeight = DrawingConstants.minuteHeight(for: dayHeight)
            VStack(spacing: 0) {
                Rectangle()
                    .stroke(lineWidth: EditorDrawingConstants.thickLineWidth)
                    .frame(height: EditorDrawingConstants.dayHeaderMinutes * minuteHeight)
                MorningTimes()
                    .frame(height: EditorDrawingConstants.morningMinutes() * minuteHeight)
                AfternoonTimes(for: position)
                    .frame(height: EditorDrawingConstants.afternoonMinutes() * minuteHeight)
            }
        }
    }
    
    init(positioned position: MainTimeTable.TimeColumnPosition) { self.position = position }
    
    // MARK: - drawing constants and calculations
    
    private struct DrawingConstants {
        
        static func minuteHeight(for dayHeight: CGFloat) -> CGFloat {
            dayHeight / EditorDrawingConstants.dayTotalMinutes()
        }
    }
}
