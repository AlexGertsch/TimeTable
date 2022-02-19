//
//  FieldDropDelegate.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 30.12.21.
//

import SwiftUI

struct FieldDropDelegate: DropDelegate {
    var field: TimeTableField
    
    init(for field: TimeTableField) {
        self.field = field
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        let providers = info.itemProviders(for: [.utf8PlainText])
        if let provider = providers.first {
            let _ = provider.loadObject(ofClass: String.self) { object, error in
                if let id = object {
                    if let movingLesson = field.editor.lesson(for: id) {
                        DispatchQueue.main.async {
                            field.editor.movingLesson = movingLesson
                        }
                    }
                }
            }
        }
        return nil
    }
    
    func performDrop(info: DropInfo) -> Bool {
        let providers = info.itemProviders(for: [.utf8PlainText])
        if let provider = providers.first(where: { $0.canLoadObject(ofClass: String.self) }) {
            let _ = provider.loadObject(ofClass: String.self) { object, error in
                if let droppedLessonId = object {
                    DispatchQueue.main.async {
                        if let movedLesson = field.editor.lesson(for: droppedLessonId),
                           field.dropAllowed {
                            field.editor.put(movedLesson, on: field.meeting)
                        }
                        field.editor.movingLesson = nil
                    }
                }
            }
            return true
        }
        return false
    }
}
