//
//  LessonView.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 21.12.21.
//

import SwiftUI

struct LessonView: View {
    var lesson: Lesson
    var roomString: String {
        lesson.room != nil ? lesson.room!.rawValue : "none"
    }
    
    init(for lesson: Lesson) {
        self.lesson = lesson
    }
    
    // MARK: - invoke room editor
    
    @State private var editingRoom = false
    
    private func doubleTapToEditRoom() -> some Gesture {
        TapGesture(count: 2)
            .onEnded {
                editingRoom = true
            }
    }
    
    // MARK: - body-composition for different kinds of lessons
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
                .gesture(doubleTapToEditRoom())
                .popover(isPresented: $editingRoom) {
                    RoomEditor(for: lesson)
                }
        }
    }
    
    private func body(for size: CGSize) -> some View {
        ZStack {
            switch lesson.kind {
            case .full:
                normalBackground(for: size)
                fullClassText(for: size)
            case .half(let halfClassType):
                normalBackground(for: size)
                halfClassText(for: size, and: halfClassType)
            case .instrumental(let duration):
                switch duration {
                case .full:
                    normalBackground(for: size)
                case .half:
                    halfInstrumentalBackground(for: size)
                default: Rectangle()
                }
                instrumentalClassText(for: size)
            }
        }
    }
    
    // MARK: - backgrounds for different kinds of lessons
    
    private func color(for teachers: [TeacherData.id]) -> Color {
        if teachers.count != 1 {
            return Color.gray.opacity(0.3)
        } else {
            return Color(TeacherData.personalData(for: teachers.first!).color)
        }
    }
    
    private func normalBackground(for size: CGSize) -> some View {
        ZStack {
            RoundedRectangle(
                cornerRadius: DrawingConstants.cornerRadius(for: size)
            )
                .foregroundColor(color(for: lesson.teachers))
            RoundedRectangle(
                cornerRadius: DrawingConstants.cornerRadius(for: size)
            )
                .stroke(lineWidth: DrawingConstants.lineWidth)
        }
    }
    
    private func halfInstrumentalBackground(for size: CGSize) -> some View {
        ZStack {
            Ellipse()
                .foregroundColor(color(for: lesson.teachers))
            Ellipse()
                .stroke(lineWidth: DrawingConstants.lineWidth)
        }
    }
    
    // MARK: - text for different lessons
    
    private func text(for teachers: [TeacherData.id]) -> String {
        if teachers.count != 1 {
            return "div."
        } else {
            return teachers.first!.rawValue
        }
    }
    
    @ViewBuilder
    func fullClassText(for size: CGSize) -> some View {
        VStack(spacing: 0) {
            Text(roomString)
            let subjectText = lesson.subject.displayed
            if subjectText.count < 3 {
                Text(lesson.subject.displayed)
                    .font(DrawingConstants.fullClassLargeFont(for: size))
            } else {
                Text(lesson.subject.displayed)
                    .font(DrawingConstants.fullClassSmallSubjectFont(for: size))
            }
            Text(text(for: lesson.teachers))
        }
        .font(DrawingConstants.fullClassSmallFont(for: size))
    }
    
    private func halfClassText(for size: CGSize, and halfClassType: Lesson.HalfClassType) -> some View {
        VStack(spacing: 0) {
            Text(roomString)
            if lesson.subject.displayed.count < 3 {
                Text(lesson.subject.displayed)
                    .font(DrawingConstants.halfClassLargeFont(for: size))
            } else {
                Text(lesson.subject.displayed)
                    .font(DrawingConstants.halfClassShrinkedLargeFont(for: size))
            }
            if halfClassType.displayed.count < 3 {
                Text(halfClassType.displayed)
                    .font(DrawingConstants.halfClassLargeFont(for: size))
            } else {
                Text(halfClassType.displayed)
                    .font(DrawingConstants.halfClassShrinkedLargeFont(for: size))
            }
            Text(text(for: lesson.teachers))
        }
        .font(DrawingConstants.halfClassSmallFont(for: size))
    }
    
    private func instrumentalClassText(for size: CGSize) -> some View {
        assert(lesson.teachers.count == 1, "LessonView: found an instrumentalLesson with more than one teacher.")
        if let instrumentalShortcut = TeacherData.personalData(for: lesson.teachers.first!).instrumentalShortcut {
            if let instrumentalIndex = lesson.instrumentalIndex {
                return Text("\(instrumentalShortcut)\n\(instrumentalIndex)")
                    .font(DrawingConstants.instrumentalFont(for: size))
            } else {
                print("LessonView: instrumental lesson \(lesson) seems to have no instrumental index!")
                return Text("")
            }
        } else {
            return Text("")
        }
            
    }
    
    // MARK: - drawing constants
    
    private struct DrawingConstants {
        
        static let lineWidth: CGFloat = 0.85
    
        static func cornerRadius(for size: CGSize) -> CGFloat {
            min(size.width, size.height) * 0.1
        }
        
        // Scaling for fullClass
        static func fullClassLargeFont(for size: CGSize) -> Font {
            Font.system(
                size: min(size.width, size.height) * 0.52
            )
        }
        static func fullClassSmallSubjectFont(for size: CGSize) -> Font {
            Font.system(
                size: min(size.width, size.height) * 0.38
            )
        }
        static func fullClassSmallFont(for size: CGSize) -> Font {
            Font.system(
                size: min(size.width, size.height) * 0.27
            )
        }
        
        // Scaling for halfClass
        static func halfClassLargeFont(for size: CGSize) -> Font {
            Font.system(
                size: min(size.width, size.height) * 0.58
            )
        }
        static func halfClassShrinkedLargeFont(for size: CGSize) -> Font {
            Font.system(
                size: min(size.width, size.height) * 0.42
            )
        }
        static func halfClassSmallFont(for size: CGSize) -> Font {
            Font.system(
                size: min(size.width, size.height) * 0.35
            )
        }
        
        // Scaling for instrumentalClass
        static func instrumentalFont(for size: CGSize) -> Font {
            Font.system(
                size: min(size.width, size.height) * 0.5
            )
        }
    }
    
}

struct LessonView_Previews: PreviewProvider {
    static var previews: some View {
        LessonView(for: Lesson(promotion: .p152c, firstOfMultiplePromotions: true, subject: .p, halfClassType: nil, teachers: [.AGe], versionNumber: 1, onlyQuarter: nil))
            .aspectRatio(2/3, contentMode: .fit)
    }
}
