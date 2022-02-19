//
//  MorningTimes.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 25.12.21.
//

import SwiftUI

struct MorningTimes: View {
    var body: some View {
        GeometryReader { geometry in
            let morningHeight = geometry.size.height
            let minuteHeight = DrawingConstants.minuteHeight(for: morningHeight)
            let slotRowHeight = EditorDrawingConstants.lessonMinutes * minuteHeight
            VStack(spacing: 0) {
                TimeFieldTuple(for: Slot.earlyMorningSlots)
                    .bordered(thick: true)
                    .frame(height: CGFloat(Slot.earlyMorningSlots.count) * slotRowHeight)
                Daybreak()
                    .bordered(thick: true)
                    .frame(height: DrawingConstants.daybreakHeight(for: minuteHeight))
                TimeFieldTuple(for: Slot.lateMorningSlots)
                    .bordered(thick: true)
                    .frame(height: CGFloat(Slot.lateMorningSlots.count) * slotRowHeight)
            }
        }
    }
    
    struct Daybreak: View {
        var body: some View {
            Rectangle().foregroundColor(.clear)
        }
    }
    
    // MARK: - drawing constants and calculations
    
    private struct DrawingConstants {
        static let daybreakScaleFactor: CGFloat = 0.55
    
        static func minuteHeight(for morningHeight: CGFloat) -> CGFloat {
            morningHeight / EditorDrawingConstants.morningMinutes()
        }
    
        static func daybreakHeight(for minuteHeight: CGFloat) -> CGFloat {
            minuteHeight * EditorDrawingConstants.dayBreakMinutes
        }
    }
}
