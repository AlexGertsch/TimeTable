//
//  RoomEditor.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 30.01.22.
//

import SwiftUI

struct RoomEditor: View {
    @EnvironmentObject var editor: TimeTableEditor
    
    var lesson: Lesson
//    var oldRoomString: String {
//        lesson.room != nil ? lesson.room!.rawValue : "Keine Raumbelegung"
//    }
    
    init(for lesson: Lesson) {
        self.lesson = lesson
        self.roomString = lesson.room != nil ? lesson.room!.rawValue : "Kürzel"
    }
    
    @State private var roomString: String
    
    var body: some View {
        Form {
            //Text("aktuell: \(oldRoomString)")
            TextField("neuer Raum:", text: $roomString)
                .onChange(of: roomString) { newRoomString in
                    validate(room: newRoomString)
                }
                .onSubmit {
                    validate(room: roomString)
                }
                .frame(maxWidth: 150)
        }
        .frame(minWidth: 300, minHeight:350)
    }
    
    private func validate(room: String) {
        for knownRoom in Room.allCases {
            if room == knownRoom.rawValue {
                editor.changeRoom(of: lesson, to: knownRoom)
                break
            }
        }
    }
}

//struct RoomEditor_Previews: PreviewProvider {
//    static var previews: some View {
//        @EnvironmentObject var editor: TimeTableEditor
//        
//        RoomEditor(for: editor.lessons.first!)
//            .previewLayout(.fixed(width: 300, height: 350))
//    }
//}
