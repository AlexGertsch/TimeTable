//
//  MainTimeTable.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 25.12.21.
//

import SwiftUI

struct MainTimeTable: View {
    let numberOfPromotions = Promotion.numberOfPromotions
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            ZStack {
                HStack(spacing: 0) {
                    TimeColumn(positioned: .beforeMonday)
                        .frame(width: timeColumnWidth(for: width),
                               height: height)
                    ForEach(Day.firstFourDays) { day in
                        DayColumn(for: day)
                            .bordered(thick: true)
                            .frame(width: dayWidth(for: width),
                                   height: height)
                    }
                    TimeColumn(positioned: .beforeFriday)
                        .frame(width: timeColumnWidth(for: width),
                               height: height)
                    DayColumn(for: Day.friday)
                        .bordered(thick: true)
                        .frame(width: dayWidth(for: width),
                               height: height)
                }
                Rectangle().stroke(lineWidth: EditorDrawingConstants.thickLineWidth)
            }
        }
    }
    
    enum TimeColumnPosition {
        case beforeMonday
        case beforeFriday
    }
    
    // MARK: - drawing calculations
        
    private func timeColumnWidth(for width: CGFloat) -> CGFloat {
        width * timeColumnToTotalWidth()
    }
        
    private func dayWidth(for width: CGFloat) -> CGFloat {
        width * CGFloat(Promotion.numberOfPromotions) / totalWidthToLessonWidth()
        }
    
    private func totalWidthToLessonWidth() -> CGFloat {
        5 * CGFloat(Promotion.numberOfPromotions) + 2 * EditorDrawingConstants.timeColumnWidthToLessonWidth
    }
    
    private func timeColumnToTotalWidth() -> CGFloat {
        EditorDrawingConstants.timeColumnWidthToLessonWidth / totalWidthToLessonWidth()
    }
}
