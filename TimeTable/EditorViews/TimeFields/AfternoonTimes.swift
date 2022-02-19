//
//  AfternoonTimes.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 25.12.21.
//

import SwiftUI

struct AfternoonTimes: View {
    let position: MainTimeTable.TimeColumnPosition
    
    var body: some View {
        GeometryReader { geometry in
            let afternoonHeight = geometry.size.height
            let minuteHeight = DrawingConstants.minuteHeight(for: afternoonHeight)
            let slotRowHeight = EditorDrawingConstants.lessonMinutes * minuteHeight
            switch position {
            case .beforeMonday:
                VStack(spacing: 0) {
                    TimeFieldTuple(for: Slot.noonSlots)
                        .bordered(thick: true)
                        .frame(height: CGFloat(Slot.noonSlots.count) * slotRowHeight)
                    TimeFieldTuple(for: Slot.earlyAfternoonSlots)
                        .bordered(thick: true)
                        .frame(height: CGFloat(Slot.earlyAfternoonSlots.count) * slotRowHeight)
                    Break()
                        .bordered(thick: false)
                        .frame(height: DrawingConstants.afternoonBreakHeight(for: minuteHeight))
                    TimeFieldTuple(for: Slot.lateAfternoonSlots)
                        .bordered(thick: true)
                        .frame(height: CGFloat(Slot.afterWeekCloseSlots.count) * slotRowHeight)
                }
            case .beforeFriday:
                VStack(spacing: 0) {
                    Break()
                        .bordered(thick: false)
                        .frame(height: DrawingConstants.fridayNoonBreakHeight(for: minuteHeight))
                    TimeFieldTuple(for: Slot.firstFridayAfternoonSlot)
                        .bordered(thick: false)
                        .frame(height: CGFloat(Slot.firstFridayAfternoonSlot.count) * slotRowHeight)
                    TimeFieldTuple(for: Slot.otherFridayAfternoonSlots)
                        .bordered(thick: true)
                        .frame(height: CGFloat(Slot.otherFridayAfternoonSlots.count) * slotRowHeight)
                    Break()
                        .bordered(thick: true)
                        .frame(height: DrawingConstants.weekCloseHeight(for: minuteHeight))
                    TimeFieldTuple(for: Slot.afterWeekCloseSlots)
                        .bordered(thick: true)
                        .frame(height: CGFloat(Slot.afterWeekCloseSlots.count) * slotRowHeight)
                }
            }
        }
    }
    
    init(for position: MainTimeTable.TimeColumnPosition) { self.position = position }
    
    struct Break: View {
        var body: some View {
            Rectangle().foregroundColor(.clear)
        }
    }
    
    // MARK: - drawing constants and calculations
    
    
    private struct DrawingConstants {
        
        static func minuteHeight(for afternoonHeight: CGFloat) -> CGFloat {
            afternoonHeight / EditorDrawingConstants.afternoonMinutes()
        }
        
        static func afternoonBreakHeight(for minuteHeight: CGFloat) -> CGFloat {
            minuteHeight * EditorDrawingConstants.afternoonBreakMinutes
        }
        
        static func fridayNoonBreakHeight(for minuteHeight: CGFloat) -> CGFloat {
            minuteHeight * EditorDrawingConstants.fridayNoonBreakMinutes()
        }
        
        static func weekCloseHeight(for minuteHeight: CGFloat) -> CGFloat {
            minuteHeight * EditorDrawingConstants.weekCloseMinutes
        }
    }
}
