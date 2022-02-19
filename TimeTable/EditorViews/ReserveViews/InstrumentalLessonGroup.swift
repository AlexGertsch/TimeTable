//
//  InstrumentalLessonGroup.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 03.01.22.
//

import SwiftUI

struct InstrumentalLessonGroup: View {
    @EnvironmentObject var editor: TimeTableEditor
    
    var promotion: Promotion
    var teacher: TeacherData.id
    
    init(
        for promotion: Promotion,
        and teacher: TeacherData.id
    ) {
        self.promotion = promotion
        self.teacher = teacher
    }
    
    var lessonsInGroup: [Lesson] {
        editor.lessons
            .filter( { $0.teachers.first == teacher } )
            .filter( { $0.isScheduledOn == nil } )
            .filter( { $0.kind == .instrumental(.full) || $0.kind == .instrumental(.half) })
            .filter( { $0.promotion == promotion } )
            .sorted { $0.instrumentalIndex! < $1.instrumentalIndex! }
    }
    
    var body: some View {
        GeometryReader { geometry in
            groupBody(for: geometry.size)
        }
    }
    
    private func groupBody(for size: CGSize) -> some View {
        let lessonHeight = size.height
        let lessonWidth = lessonHeight * DrawingConstants.instrumentalAspectRatio
        return ZStack {
            Rectangle().opacity(0)
            HStack(spacing: 0) {
                ForEach(lessonsInGroup) { lesson in
                    LessonView(for: lesson)
                        .frame(width: lessonWidth, height: lessonHeight)
                        .onDrag { NSItemProvider(object: lesson.id as NSString) }
                }
                Spacer(minLength: 0)
            }
        }
    }
    
    private struct DrawingConstants {
        static var instrumentalAspectRatio: CGFloat {
            EditorDrawingConstants.instrResAspectRatio
        }
    }
}

