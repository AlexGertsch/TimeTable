//
//  ReserveLessonGrid.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 31.12.21.
//

import SwiftUI

struct ReserveLessonGrid: View {
    var lessonRows: [IdentifiedLessonRow]
    var aspectRatio: CGFloat
    var maximalLessonHeight: CGFloat
    var rowCount: Int
    var columnCount: Int
    
    init(
        for lessons: [Lesson],
        with aspectRatio: CGFloat,
        and maximalLessonHeight: CGFloat,
        rowCount: Int
    ) {
        self.aspectRatio = aspectRatio
        self.maximalLessonHeight = maximalLessonHeight
        self.rowCount = rowCount
        columnCount = ReserveLessonGrid.columnCount(for: lessons, and: rowCount)
        
        var newLessonRows = [IdentifiedLessonRow]()
        for rowIndex in 0..<rowCount {
            var newlessonRow = [Lesson]()
            for columnIndex in 0..<columnCount {
                let lessonIndex = rowIndex * columnCount + columnIndex
                if lessonIndex < lessons.count {
                    newlessonRow.append(lessons[lessonIndex])
                } else {
                    break
                }
            }
            newLessonRows.append(IdentifiedLessonRow(id: rowIndex, lessons: newlessonRow))
        }
        lessonRows = newLessonRows
    }
    
    static func columnCount(for lessons: [Lesson], and rowCount: Int) -> Int {
        if lessons.isEmpty { return 1 }
        else {
            return (lessons.count - 1) / rowCount + 1
        }
    }
    
    struct IdentifiedLessonRow: Identifiable {
        var id: Int
        var lessons: [Lesson]
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ForEach(lessonRows) { lessonRow in
                    HStack(spacing: 0) {
                        ForEach(lessonRow.lessons) { lesson in
                            LessonView(for: lesson)
                                .onDrag { NSItemProvider(object: lesson.id as NSString) }
                                .frame(width: widthThatFits(for: geometry.size), height: widthThatFits(for: geometry.size) / aspectRatio)
                        }
                        Spacer(minLength: 0)
                    }
                }
                Spacer(minLength: 0)
            }
        }
    }
    
    private func widthThatFits(for size: CGSize) -> CGFloat {
        var fittingWidth = size.width / CGFloat(columnCount)
        let widthForFullColumns = size.height * aspectRatio / CGFloat(rowCount)
        if fittingWidth > widthForFullColumns {
            fittingWidth = widthForFullColumns
        }
        if fittingWidth > maximalLessonHeight * aspectRatio {
            fittingWidth = maximalLessonHeight * aspectRatio
        }
        return fittingWidth
    }
}
