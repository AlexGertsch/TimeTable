//
//  TimeTableEditor.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 24.12.21.
//

import Foundation

// viewController, connecting timeTable and editorView
class TimeTableEditor: ObservableObject {
    @Published private var timeTable: TimeTable {
        didSet {
            autosave()
        }
    }
    
    @Published var movingLesson: Lesson?
    
    init() {
        if let url = Autosave.url, let autosavedTimeTable = try? TimeTable(url: url) {
            timeTable = autosavedTimeTable
        } else {
            timeTable = TimeTable()
        }
    }
    
    // MARK: - access to timeTable model
    
    var lessons: [Lesson] { timeTable.lessons }
    
    func lessons(for promotion: Promotion, and meeting: Meeting) -> [Lesson] {
        timeTable.lessons(for: promotion, and: meeting)
    }
    
    // MARK: - intent(s)
    
    func lesson(for id: String) -> Lesson? {
        timeTable.lesson(for: id)
    }
    
    func put(_ lesson: Lesson, on meeting: Meeting) {
        timeTable.put(lesson, on: meeting)
    }
    
    func remove(_ lesson: Lesson) {
        timeTable.remove(lesson)
    }
    
    func changeRoom(of lesson: Lesson, to room: Room?) {
        timeTable.changeRoom(of: lesson, to: room)
    }
    
    // MARK: - storage functionality
    
    private func autosave() {
        if let url = Autosave.url {
            save(to: url)
        }
    }
    
    private struct Autosave {
        static let filename = "Autosaved.timetable"
        static var url: URL? {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            return documentDirectory?.appendingPathComponent(filename)
        }
    }
    
    private func save(to url: URL) {
        let thisfunction = "\(String(describing: self)).\(#function)"
        do {
            let data: Data = try timeTable.json()
            // print("\(thisfunction) json = \(String(data: data, encoding: .utf8) ?? "nil")")
            try data.write(to: url)
        } catch let encodingError where encodingError is EncodingError {
            print("\(thisfunction) couldn't encode timeTable as JSON because of \(encodingError.localizedDescription)")
        } catch {
            print("\(thisfunction) error = \(error)")
        }
    }
    
}
