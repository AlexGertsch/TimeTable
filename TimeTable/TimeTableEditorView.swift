//
//  TimeTableEditorView.swift
//  TimeTable
//
//  Created by stundenplan on 12.02.22.
//

import SwiftUI

struct TimeTableEditorView: View {
    @EnvironmentObject var editor: TimeTableEditor
    
    var body: some View {
        let editorDropDelegate = EditorDropDelegate(editor: editor)
        GeometryReader { geometry in
            timeTableBody()
                .padding(EditorDrawingConstants.border(for: geometry.size))
                .onDrop(of: [.utf8PlainText], delegate: editorDropDelegate)
        }
    }
    
    private func timeTableBody() -> some View {
        GeometryReader { geometry in
            arrangeTimeTableComponents(for: geometry.size)
        }
        
    }
    
    private func arrangeTimeTableComponents(for size: CGSize) -> some View {
        VStack(spacing: 0) {
            MainTimeTable()
                .frame(height: EditorDrawingConstants.mainTimeTableHeight(for: size))
            Spacer(minLength: EditorDrawingConstants.spacerHeight(for: size))
            MainReserve()
                .frame(height: EditorDrawingConstants.mainReserveHeight(for: size))
            Spacer(minLength: EditorDrawingConstants.spacerHeight(for: size))
            ButtonStrip()
                .frame(height: EditorDrawingConstants.buttonStripHeight(for: size))
        }
    }
    
    struct EditorDropDelegate: DropDelegate {
        var editor: TimeTableEditor
        
        func dropUpdated(info: DropInfo) -> DropProposal? {
            let providers = info.itemProviders(for: [.utf8PlainText])
            if let provider = providers.first {
                let _ = provider.loadObject(ofClass: String.self) { object, error in
                    if let id = object {
                        if let movingLesson = editor.lesson(for: id) {
                            DispatchQueue.main.async {
                                editor.movingLesson = movingLesson
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
                    DispatchQueue.main.async {
                        editor.movingLesson = nil
                    }
                }
                return true
            }
            return false
        }
    }
}















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TimeTableEditorView()
    }
}
