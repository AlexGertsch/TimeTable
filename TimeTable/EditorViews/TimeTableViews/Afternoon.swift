//
//  Afternoon.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 25.12.21.
//

import SwiftUI

struct Afternoon: View {
    @EnvironmentObject var editor: TimeTableEditor
    let day: Day
    
    var body: some View {
        GeometryReader { geometry in
            let afternoonHeight = geometry.size.height
            let minuteHeight = DrawingConstants.minuteHeight(for: afternoonHeight)
            let slotRowHeight = EditorDrawingConstants.lessonMinutes * minuteHeight
            if day != Day.friday {
                VStack(spacing: 0) {
                    SlotRowTuple(on: day, for: Slot.noonSlots)
                        .bordered(thick: true)
                        .frame(height: CGFloat(Slot.noonSlots.count) * slotRowHeight)
                    SlotRowTuple(on: day, for: Slot.earlyAfternoonSlots)
                        .bordered(thick: true)
                        .frame(height: CGFloat(Slot.earlyAfternoonSlots.count) * slotRowHeight)
                    Break()
                        .bordered(thick: false)
                        .frame(height: DrawingConstants.afternoonBreakHeight(for: minuteHeight))
                    SlotRowTuple(on:day, for: Slot.lateAfternoonSlots)
                        .bordered(thick: true)
                        .frame(height: CGFloat(Slot.lateAfternoonSlots.count) * slotRowHeight)
                }
            } else {
                VStack(spacing: 0) {
                    Break()
                        .bordered(thick: false)
                        .frame(height: DrawingConstants.fridayNoonBreakHeight(for: minuteHeight))
                    SlotRowTuple(on: day, for: Slot.firstFridayAfternoonSlot)
                        .bordered(thick: false)
                        .frame(height: CGFloat(Slot.firstFridayAfternoonSlot.count) * slotRowHeight)
                    SlotRowTuple(on: day, for: Slot.otherFridayAfternoonSlots)
                        .bordered(thick: true)
                        .frame(height: CGFloat(Slot.otherFridayAfternoonSlots.count) * slotRowHeight)
                    WeekClose()
                        .bordered(thick: false)
                        .frame(height: DrawingConstants.weekCloseHeight(for: minuteHeight))
                    SlotRowTuple(on: day, for: Slot.afterWeekCloseSlots)
                        .bordered(thick: true)
                        .frame(height: CGFloat(Slot.afterWeekCloseSlots.count) * slotRowHeight)
                }
            }
        }
    }
    
    struct WeekClose: View {
        var body: some View {
            Text("Wochenschluss 15:15 – 15:45").labelify(with: DrawingConstants.weekCloseScaleFactor)
        }
    }
    
    struct Break: View {
        var body: some View {
            Rectangle().opacity(EditorDrawingConstants.opacityForGrays)
        }
    }
    
    init(for day: Day) {
        self.day = day
    }
    
    // MARK: - drawing constants and calculations
    
    private struct DrawingConstants {
    
        static let weekCloseScaleFactor: CGFloat = 0.5
        
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
