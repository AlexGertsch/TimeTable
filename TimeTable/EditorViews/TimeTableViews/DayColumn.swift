//
//  DayColumn.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 25.12.21.
//

import SwiftUI

struct DayColumn: View {
    let day: Day
    
    var body: some View {
        GeometryReader { geometry in
            let dayHeight = geometry.size.height
            let minuteHeight = DrawingConstants.minuteHeight(for: dayHeight)
            ZStack {
                VStack(spacing: 0) {
                    DayHeader(for: day)
                        .frame(height: DrawingConstants.headerHeight(for: minuteHeight))
                    Morning(for: day)
                        .frame(height: EditorDrawingConstants.morningMinutes() * minuteHeight)
                    Afternoon(for: day)
                        .frame(height: EditorDrawingConstants.afternoonMinutes() * minuteHeight)
                }
                Rectangle().stroke(lineWidth: EditorDrawingConstants.thickLineWidth)
            }
        }
    }
    
    init(for day: Day) {
        self.day = day
    }
    
    // MARK: - drawing calculations
    
    private struct DrawingConstants {
        static func headerHeight(for minuteHeight: CGFloat) -> CGFloat {
            EditorDrawingConstants.dayHeaderMinutes * minuteHeight
        }
        
        static func minuteHeight(for dayHeight: CGFloat) -> CGFloat {
            dayHeight / EditorDrawingConstants.dayTotalMinutes()
        }
    }
    
    
}
