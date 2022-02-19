//
//  InstrumentalTeacherColumn.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 03.01.22.
//

import SwiftUI

struct InstrumentalTeacherColumn: View {
    var teacher: TeacherData.id
    
    init(for teacher: TeacherData.id) {
        self.teacher = teacher
    }
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    private func body(for size: CGSize) -> some View {
        VStack(spacing: size.height * DrawingConstants.verticalSpacingToTotalHeight) {
            TeacherLabel(teacher: teacher)
                .frame(height: size.height * DrawingConstants.teacherLabelToTotalHeight)
            ForEach(Promotion.allCases) { promotion in
                InstrumentalLessonGroup(for: promotion, and: teacher)
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
    
    struct TeacherLabel: View {
        var teacher: TeacherData.id
        
        var body: some View {
            GeometryReader { geometry in
                let instrumentalShortcut = TeacherData.personalData(for: teacher).instrumentalShortcut!
                ZStack {
                    Rectangle().foregroundColor(Color(TeacherData.personalData(for: teacher).color))
                    VStack(spacing: 0) {
                        Text(teacher.rawValue)
                        Text(instrumentalShortcut)
                    }
                        .font(teacherFont(for: geometry.size))
                }
            }
        }
        
        // MARK: - drawing constants
        
        private func teacherFont(for size: CGSize) -> Font {
            Font.system(size: size.height * EditorDrawingConstants.instrResTeacherLabelScaleFactor)
        }
    }
}
