//
//  EditorDrawingConstants.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 25.12.21.
//

import SwiftUI

struct EditorDrawingConstants {
    
    // MARK: - vertical dimensions of TimeTableEditorView
    
    static let mainTimeTableToTotalHeight: CGFloat = 0.65 // 0.65
    static let buttonStripToTotalHeight: CGFloat = 0.04
    static let spacerToTotalHeight: CGFloat = 0.005
    
    static var mainReserveToTotalHeight: CGFloat {
        1 - buttonStripToTotalHeight - mainTimeTableToTotalHeight - 2 * spacerToTotalHeight
    }
    static func buttonStripHeight(for size: CGSize) -> CGFloat {
        buttonStripToTotalHeight * size.height
    }
    static func spacerHeight(for size: CGSize) -> CGFloat {
        spacerToTotalHeight * size.height
    }
    static func mainTimeTableHeight(for size: CGSize) -> CGFloat {
        mainTimeTableToTotalHeight * size.height
    }
    static func mainReserveHeight(for size: CGSize) -> CGFloat {
        mainReserveToTotalHeight * size.height
    }
    
    static func border(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.004
    }
    
    // MARK: - vertical dimensions in MainTimeTable
    
    static let lessonMinutes: CGFloat = 45
    static let dayHeaderMinutes: CGFloat = 35
    static let dayBreakMinutes: CGFloat = 25
    static let afternoonBreakMinutes: CGFloat = 10
    static let weekCloseMinutes: CGFloat = 30
    
    static func dayTotalMinutes() -> CGFloat {
        return dayHeaderMinutes + dayBreakMinutes + afternoonBreakMinutes + 11 * lessonMinutes
    }
    
    static func morningMinutes() -> CGFloat {
        return dayBreakMinutes + 5 * lessonMinutes
    }
    
    static func afternoonMinutes() -> CGFloat {
        return afternoonBreakMinutes + 6 * lessonMinutes
    }
    
    static func fridayNoonBreakMinutes() -> CGFloat {
        let difference = afternoonMinutes() - weekCloseMinutes - (5 * lessonMinutes)
        assert(difference >= 0, "TimeTableViewDimensions: fridayNoonBreakMinutes has a negative value!")
        return difference
    }
    
    // MARK: - horizontal dimensions in MainTimeTable
    
    static let timeColumnWidthToLessonWidth: CGFloat = 1.1
    
    // MARK: - constants for MainReserve
    
    static let instrumentalReserveToWidth: CGFloat = 0.29
    static let promotionSpacerToWidth: CGFloat = 0.003
    
    // MARK: - constants for PromotionReserve
    
    static let reservePromotionLabelToHeight: CGFloat = 0.04
    static let fullClassAspectRatio: CGFloat = 2/3
    static let halfClassAspectRatio: CGFloat = 1/3
    static let promotionReserveSpacingToTotalHeight: CGFloat = 0.01
    static let maximalLessonToReserveHeight: CGFloat = 0.28
    
    static func fullClassRowCount(for lessons: [Lesson]) -> Int {
        switch lessons.count {
        case 0...3: return 1
        case 4...6: return 2
        case 7...9: return 3
        case 10...12,16: return 4
        case 13...15,17...20: return 5
        case 21...24: return 6
        default: return 7
        }
    }
    
    static func halfClassRowCount(for lessons: [Lesson]) -> Int {
        switch lessons.count {
        case 0...7: return 1
        case 8...14: return 2
        default: return 3
        }
    }
    
    // MARK: - constants for instrumental reserve
    
    static let instrResScrollHeightReductionFactor: CGFloat = 0.955
    
    static let instrResTeacherLabelToTotalHeight: CGFloat = 0.08
    static let instrResVerticalSpacingToTotalHeight: CGFloat = 0.007
    static let instrResHorizontalSpacingToWidth: CGFloat = 0.0084
    static let instrResPromotionLabelScaleFactor: CGFloat = 0.6
    static let instrResTeacherLabelScaleFactor: CGFloat = 0.4
    static let instrResMinimalColumnToTotalWidth: CGFloat = 0.051
    static let instrResPromotionColumnToTotalWidth: CGFloat = 0.05
    
    static let instrResAspectRatio: CGFloat = 0.6
    
    
    // MARK: - lineWidths
    
    static let thinLineWidth: CGFloat = 0.5
    static let middleLineWidth: CGFloat = 0.85
    static let thickLineWidth: CGFloat = 2.5
    
    // MARK: - drag & drop
    
    static let colorForAllowedDropping: Color = .blue
    static let colorForForbiddenDropping: Color = .red
    static let opacityForHighlighting: Double = 0.5
    
    // MARK: - other
    
    static let opacityForGrays: Double = 0.12
    
    
    
}
