//
//  ButtonStrip.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 26.12.21.
//

import SwiftUI

struct ButtonStrip: View {
    @EnvironmentObject var editor: TimeTableEditor
    
    var body: some View {
        ZStack {
            Rectangle().stroke(lineWidth: EditorDrawingConstants.thickLineWidth)
            HStack {
                Button(action: startExport) {
                    Text("SN Export")
                }
                Text("ButtonStrip").font(.footnote)
            }
        }
    }
    
    private func startExport() {
        var exporter = SNExporter(for: editor)
        exporter.sNExport()
    }
}
