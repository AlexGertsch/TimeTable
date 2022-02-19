//
//  TimeTableField.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 22.12.21.
//

import SwiftUI

struct TimeTableField: View {
    @EnvironmentObject var editor: TimeTableEditor
    
    let promotion: Promotion
    let meeting: Meeting
    
    init(
        for promotion: Promotion,
        and meeting: Meeting
    ) {
        self.promotion = promotion
        self.meeting = meeting
    }
    
    // MARK: - computed vars
    
    var lessons: [Lesson] {
        editor.lessons(for: promotion, and: meeting) //(for: promotion, on: day, and: slot)
    }
    
    var oneAndOnlyFullClassLesson: Lesson? {
        if lessons.contains(where: { $0.kind == .full }) {
            assert(lessons.count == 1, "TimeTableFieldView: more than one and only fullClassLesson to display!")
            return lessons.first
        }
        return nil
    }
    
    var halfClassLessons: [Lesson] {
        var foundLessons = [Lesson]()
        for lesson in lessons {
            switch lesson.kind {
            case .half(_): foundLessons.append(lesson)
            default: break
            }
        }
        return foundLessons
    }
    
    var instrumentalLessons: [Lesson] {
        var foundLessons = [Lesson]()
        for lesson in lessons {
            switch lesson.kind {
            case .instrumental(_): foundLessons.append(lesson)
            default: break
            }
        }
        return foundLessons
    }
    
    var instrumentalColumnCount: Int {
        if instrumentalLessons.isEmpty {
            return 0
        } else {
            return (instrumentalLessons.count - 1) / DrawingConstants.maxNumberOfInstrumentalLessonsPerColumn + 1
        }
    }
    
    var columnCount: Int {
        assert(oneAndOnlyFullClassLesson == nil, "TimeTableField: columnCount called, although there is one and only fullClassLesson in field")
        if halfClassLessons.count == 1, instrumentalColumnCount == 0 {
            return 2
        } else {
            return halfClassLessons.count + instrumentalColumnCount
        }
    }
    
    // MARK: - drag & drop
    
    var dropAllowed: Bool {
        if let movingLesson = editor.movingLesson {
            return FieldDropChecker.dropAllowed(for: movingLesson, on: self)
        }
        return false
    }
    
    var highlightingColor: Color? {
        if let movingLesson = editor.movingLesson, movingLesson.promotion == promotion {
            if dropAllowed { return EditorDrawingConstants.colorForAllowedDropping }
            else { return EditorDrawingConstants.colorForForbiddenDropping }
        }
        return nil
    }
    
    // MARK: - body formation
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
                .onDrop(of: [.utf8PlainText], delegate: FieldDropDelegate(for: self))
        }
    }
    
    //@ViewBuilder
    private func body(for size: CGSize) -> some View {
        ZStack {
            let field = Rectangle()
            field.fill().foregroundColor(.white)
            if highlightingColor != nil {
                field
                    .foregroundColor(highlightingColor)
                    .opacity(EditorDrawingConstants.opacityForHighlighting)
            }
            field.strokeBorder(lineWidth: EditorDrawingConstants.thinLineWidth)
            
            // only if the lesson-array contains lessons, they have to be arranged
            if !lessons.isEmpty {
                lessonViewArrangement()
                    .padding(DrawingConstants.standardPadding(for: size))
            }
        }
    }
    
    private func lessonViewArrangement() -> some View {
        GeometryReader { geometry in
            // if the field contains a fullClassLesson, it fills the whole field
            if let fullClassLesson = oneAndOnlyFullClassLesson {
                LessonView(for: fullClassLesson)
                    .onDrag { NSItemProvider(object: fullClassLesson.id as NSString) }
            // otherwise, the halfClass- and instrumentalLessons have to be arranged
            // depending on their numbers
            } else {
                arrangeHalfAndInstrumentalClasses()
            }
        }
    }
    
    private func arrangeHalfAndInstrumentalClasses() -> some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(halfClassLessons) { halfClassLesson in
                    LessonView(for: halfClassLesson)
                        .onDrag { NSItemProvider(object: halfClassLesson.id as NSString) }
                        .frame(width: geometry.size.width / CGFloat(columnCount))
                }
                if instrumentalColumnCount > 0 {
                    instrumentalGrid(with: geometry.size.width / CGFloat(columnCount))
                } else {
                  Spacer(minLength: 0)
                }
            }
        }
        
    }
    
    private func instrumentalGrid(with columnWidth: CGFloat) -> some View {
        var instrumentalColumns = [GridItem]()
        for _ in 0..<instrumentalColumnCount {
            var gridItem = GridItem(.fixed(columnWidth))
            gridItem.spacing = 0
            instrumentalColumns.append(gridItem)
        }
        var sortedInstrumentalLessons: [Lesson] {
            var newInstrumentalLessons = [Lesson]()
            for teacher in TeacherData.instrumentalTeachersSortedByShortCut {
                let lessonsForTeacher = instrumentalLessons.filter { $0.teachers.first! == teacher }
                newInstrumentalLessons += lessonsForTeacher.sorted { $0.instrumentalIndex! < $1.instrumentalIndex! }
            }
            return newInstrumentalLessons
        }
        return GeometryReader { geometry in
            LazyVGrid(columns: instrumentalColumns, spacing: 0) {
                ForEach(sortedInstrumentalLessons) { lesson in
                    LessonView(for: lesson)
                        .onDrag { NSItemProvider(object: lesson.id as NSString) }
                        //.padding(DrawingConstants.instrumentalPadding(for: geometry.size))
                        .frame(
                            width: instrumentalLessonWidth(for: geometry.size, and: columnWidth),
                            height: instrumentalLessonWidth(for: geometry.size, and: columnWidth) / DrawingConstants.instrumentalAspectRatio
                        )
                }
            }
        }
    }
    
    private func instrumentalLessonWidth(for size: CGSize, and columnWidth: CGFloat) -> CGFloat {
        let absoluteMaxHeight = size.height * DrawingConstants.maxInstrumentalHeightToHeight
        let maxHeightDueToLessonsInColumn = size.height / CGFloat(min(DrawingConstants.maxNumberOfInstrumentalLessonsPerColumn, instrumentalLessons.count))
        let maxHeight = min(absoluteMaxHeight, maxHeightDueToLessonsInColumn)
        let maxWidth = maxHeight * DrawingConstants.instrumentalAspectRatio
        return min(maxWidth, columnWidth)
    }
    
    // MARK: - drawing constants
    
    private struct DrawingConstants {
        static let maxNumberOfInstrumentalLessonsPerColumn: Int = 4
        
        static let maxInstrumentalHeightToHeight: CGFloat = 1/3
        static let instrumentalAspectRatio: CGFloat = 3/5
        
        static func standardPadding(for size: CGSize) -> CGFloat {
            min(size.width, size.height) * 0.07
        }
        
        static func instrumentalPadding(for size: CGSize) -> CGFloat {
            min(size.width, size.height) * 0.0
        }
    }
}










//struct TimeTableField_Previews: PreviewProvider {
//    static var previews: some View {
//        TimeTableField()
//    }
//}
