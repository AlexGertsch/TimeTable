//
//  Morning.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 25.12.21.
//

import SwiftUI

struct Morning: View {
    let day: Day
    
    var body: some View {
        GeometryReader { geometry in
            let morningHeight = geometry.size.height
            let minuteHeight = DrawingConstants.minuteHeight(for: morningHeight)
            let slotRowHeight = EditorDrawingConstants.lessonMinutes * minuteHeight
            VStack(spacing: 0) {
                SlotRowTuple(on: day, for: Slot.earlyMorningSlots)
                    .bordered(thick: true)
                    .frame(height: CGFloat(Slot.earlyMorningSlots.count) * slotRowHeight)
                Daybreak(for: day)
                    .bordered(thick: false)
                    .frame(height: DrawingConstants.daybreakHeight(for: minuteHeight))
                SlotRowTuple(on: day, for: Slot.lateMorningSlots)
                    .bordered(thick: true)
                    .frame(height: CGFloat(Slot.lateMorningSlots.count) * slotRowHeight)
            }
        }
    }
    
    init(for day: Day) {
        self.day = day
    }
    
    struct Daybreak: View {
        let day: Day
        var body: some View {
            if day != Day.friday {
                Text("Tagesanfang 10:35 – 10:45")
                    .labelify(with: DrawingConstants.daybreakFontScaleFactor)
            } else {
                Text("Grosse Pause 10:15 – 10:45")
                    .labelify(with: DrawingConstants.daybreakFontScaleFactor)
            }
        }
        
        init(for day: Day) { self.day = day }
    }
    
    // MARK: - drawing constants and calculations
    
    private struct DrawingConstants {
        static let daybreakFontScaleFactor: CGFloat = 0.55
        
        static func minuteHeight(for morningHeight: CGFloat) -> CGFloat {
            morningHeight / EditorDrawingConstants.morningMinutes()
        }
        
        static func daybreakHeight(for minuteHeight: CGFloat) -> CGFloat {
            minuteHeight * EditorDrawingConstants.dayBreakMinutes
        }
    }
}
