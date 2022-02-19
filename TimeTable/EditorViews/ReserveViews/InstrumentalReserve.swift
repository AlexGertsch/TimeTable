//
//  InstrumentalReserve.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 03.01.22.
//

import SwiftUI

struct InstrumentalReserve: View {
    @EnvironmentObject var editor: TimeTableEditor
    
    var lessons: [Lesson] {
        editor.lessons
            .filter( { $0.kind == .instrumental(.full) || $0.kind == .instrumental(.half) })
            .filter( { $0.isScheduledOn == nil } )
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal) {
                scrollBody(for: CGSize(
                    width: geometry.size.width,
                    height: geometry.size.height * DrawingConstants.scrollHeightReductionFactor)
                )
            }
        }
    }
    
    private func scrollBody(for size: CGSize) -> some View {
        HStack(spacing: horizontalSpacing(for: size)) {
            InstrumentalPromotionColumn()
                .frame(width: promotionColumnWidth(for: size), height: size.height)
            ForEach(TeacherData.instrumentalTeachers) { teacher in
                InstrumentalTeacherColumn(for: teacher)
                    .frame(width: columnWidth(for: size, and: teacher), height: size.height)
            }
            InstrumentalPromotionColumn()
                .frame(width: promotionColumnWidth(for: size), height: size.height)
        }
    }
    
    private func columnWidth(for size: CGSize, and teacher: TeacherData.id) -> CGFloat {
        let columnWidthFromLessons = CGFloat(maximalLessonsInColumn(for: teacher)) * lessonWidth(for: size)
        return max(columnWidthFromLessons, minimalColumnWidth(for: size))
    }
    
    private func maximalLessonsInColumn(for teacher: TeacherData.id) -> Int {
        var lessonsForTeacher: [Lesson] {
            lessons.filter( { $0.teachers.first == teacher } )
        }
        var maximumCount = 0
        for promotion in Promotion.allCases {
            maximumCount = max(maximumCount, lessonsForTeacher.filter( { $0.promotion == promotion } ).count)
        }
        return maximumCount
    }
    
    // MARK: - drawing calculations
    
    private func horizontalSpacing(for size: CGSize) -> CGFloat {
        size.width * DrawingConstants.horizontalSpacingToWidth
    }
    
    private func lessonHeight(for size: CGSize) -> CGFloat {
        size.height * DrawingConstants.instrumentalLessonGroupToTotalHeight
    }
    
    private func lessonWidth(for size: CGSize) -> CGFloat {
        lessonHeight(for: size) * DrawingConstants.instrumentalAspectRatio
    }
    
    private func minimalColumnWidth(for size: CGSize) -> CGFloat {
        size.width * DrawingConstants.minimalColumnToTotalWidth
    }
    
    private func promotionColumnWidth(for size: CGSize) -> CGFloat {
        size.width * DrawingConstants.promotionColumnToTotalWidth
    }
    
    private struct DrawingConstants {
        static var scrollHeightReductionFactor: CGFloat {
            EditorDrawingConstants.instrResScrollHeightReductionFactor
        }
        static var horizontalSpacingToWidth: CGFloat {
            EditorDrawingConstants.instrResHorizontalSpacingToWidth
        }
        
        static var teacherLabelToTotalHeight: CGFloat {
            EditorDrawingConstants.instrResTeacherLabelToTotalHeight
        }
        
        static var verticalSpacingToTotalHeight: CGFloat {
            EditorDrawingConstants.instrResVerticalSpacingToTotalHeight
        }
        
        static var instrumentalLessonGroupToTotalHeight: CGFloat {
            (1 - CGFloat(1 + Promotion.numberOfPromotions) * verticalSpacingToTotalHeight - teacherLabelToTotalHeight) / CGFloat(Promotion.numberOfPromotions)
        }
        
        static var instrumentalAspectRatio: CGFloat {
            EditorDrawingConstants.instrResAspectRatio
        }
        
        static var minimalColumnToTotalWidth: CGFloat {
            EditorDrawingConstants.instrResMinimalColumnToTotalWidth
        }
        
        static var promotionColumnToTotalWidth: CGFloat {
            EditorDrawingConstants.instrResPromotionColumnToTotalWidth
        }
        
    }
    
    
}

