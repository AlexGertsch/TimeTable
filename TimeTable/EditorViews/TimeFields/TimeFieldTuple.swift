//
//  TimeFieldTuple.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 25.12.21.
//

import SwiftUI

struct TimeFieldTuple: View {
    let slots: [Slot]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 0) {
                    ForEach(slots) {slot in
                        TimeFieldView(for: slot)
                            .frame(height: geometry.size.height / CGFloat(slots.count))
                    }
                }
                Rectangle().stroke(lineWidth: EditorDrawingConstants.thickLineWidth)
            }
            
        }
    }
    
    init(for slots: [Slot]) { self.slots = slots }
}
