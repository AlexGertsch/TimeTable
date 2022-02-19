//
//  InstrumentalPromotionColumn.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 04.01.22.
//

import SwiftUI

struct InstrumentalPromotionColumn: View {
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    private func body(for size: CGSize) -> some View {
        VStack(spacing: size.height * DrawingConstants.verticalSpacingToTotalHeight) {
            Rectangle().opacity(EditorDrawingConstants.opacityForGrays)
                .frame(height: size.height * DrawingConstants.teacherLabelToTotalHeight)
            ForEach(Promotion.allCases) { promotion in
                PromotionLabel(promotion: promotion)
                    .frame(height: size.height * DrawingConstants.instrumentalLessonGroupToTotalHeight)
            }
            Spacer(minLength: 0)
        }
    }
    
    private struct DrawingConstants {
        static var teacherLabelToTotalHeight: CGFloat {
            EditorDrawingConstants.instrResTeacherLabelToTotalHeight
        }
        
        static var verticalSpacingToTotalHeight: CGFloat {
            EditorDrawingConstants.instrResVerticalSpacingToTotalHeight
        }
        
        static var instrumentalLessonGroupToTotalHeight: CGFloat {
            (1 - CGFloat(1 + Promotion.numberOfPromotions) * verticalSpacingToTotalHeight - teacherLabelToTotalHeight) / CGFloat(Promotion.numberOfPromotions)
        }
    }
    
    struct PromotionLabel: View {
        var promotion: Promotion
        
        var body: some View {
            GeometryReader { geometry in
                ZStack {
                    Rectangle().opacity(EditorDrawingConstants.opacityForGrays)
                    Text(promotion.displayed)
                        .font(promotionFont(for: geometry.size))
                }
            }
        }
        
        // MARK: - drawing constants
        
        private func promotionFont(for size: CGSize) -> Font {
            Font.system(size: size.height * EditorDrawingConstants.instrResPromotionLabelScaleFactor)
        }
    }
}
