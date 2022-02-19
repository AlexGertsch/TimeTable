//
//  PromotionReserve.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 30.12.21.
//

import SwiftUI

struct PromotionReserve: View {
    @EnvironmentObject var editor: TimeTableEditor
    var promotion: Promotion
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    private func body(for size: CGSize) -> some View {
        VStack(spacing: spacingHeight(for: size)) {
            Text("Klasse \(promotion.displayed) (\(promotion.rawValue))")
                .labelify()
                .frame(height: promotionLabelHeight(for: size))
            ReserveLessonGrid(
                for: fullClassLessons,
                with: EditorDrawingConstants.fullClassAspectRatio,
                and: maximalClassHeight(for: size),
                rowCount: fullClassRowCount
            )
                .frame(height: fullClassReserveHeight(for: size))
            ReserveLessonGrid(
                for: halfClassLessons,
                with: EditorDrawingConstants.halfClassAspectRatio,
                and: maximalClassHeight(for: size),
                rowCount: halfClassRowCount
            )
                .frame(height: halfClassReserveHeight(for: size))
        }
    }
    
    init(for promotion: Promotion) {
        self.promotion = promotion
    }
    
    var lessonsInPromotionReserve: [Lesson] {
        editor.lessons.filter { $0.isScheduledOn == nil && $0.promotion == promotion }
    }
    
    var fullClassLessons: [Lesson] {
        var foundLessons = [Lesson]()
        for lesson in lessonsInPromotionReserve {
            switch lesson.kind {
            case .full: foundLessons.append(lesson)
            default: break
            }
        }
        return foundLessons
    }
    
    var halfClassLessons: [Lesson] {
        var foundLessons = [Lesson]()
        for lesson in lessonsInPromotionReserve {
            switch lesson.kind {
            case .half(_): foundLessons.append(lesson)
            default: break
            }
        }
        return foundLessons
    }
    
    var fullClassRowCount: Int {
        EditorDrawingConstants.fullClassRowCount(for: fullClassLessons)
    }
    
    var halfClassRowCount: Int {
        EditorDrawingConstants.halfClassRowCount(for: halfClassLessons)
    }
    
    private func maximalClassHeight(for size: CGSize) -> CGFloat {
        size.height * EditorDrawingConstants.maximalLessonToReserveHeight
    }
    
    private func fullClassReserveHeight(for size: CGSize) -> CGFloat {
        classReservesHeight(for: size) * CGFloat(fullClassRowCount) / CGFloat(fullClassRowCount + halfClassRowCount)
    }
    
    private func halfClassReserveHeight(for size: CGSize) -> CGFloat {
        classReservesHeight(for: size) * CGFloat(halfClassRowCount) / CGFloat(fullClassRowCount + halfClassRowCount)
    }
    
    private func spacingHeight(for size: CGSize) -> CGFloat {
        size.height * EditorDrawingConstants.promotionReserveSpacingToTotalHeight
    }
    
    private func promotionLabelHeight(for size: CGSize) -> CGFloat {
        size.height * EditorDrawingConstants.reservePromotionLabelToHeight
    }
    
    private func classReservesHeight(for size: CGSize) -> CGFloat {
        size.height - promotionLabelHeight(for: size) - 2 * spacingHeight(for: size)
    }
}
















struct PromotionReserve_Previews: PreviewProvider {
    static var previews: some View {
        PromotionReserve(for: .p152c)
    }
}
