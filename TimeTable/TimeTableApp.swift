//
//  TimeTableApp.swift
//  TimeTable
//
//  Created by stundenplan on 12.02.22.
//

import SwiftUI

@main
struct TimeTableApp: App {
    // @StateObject declares the timeTableEditor as a source of truth
    @StateObject var editor = TimeTableEditor()
    
    var body: some Scene {
        WindowGroup {
            TimeTableEditorView()
                .environmentObject(editor)
            // the timeTableEditor is injected to the TimeTableEditorView
            // itself and all the Views inside it!
        }
    }
}
