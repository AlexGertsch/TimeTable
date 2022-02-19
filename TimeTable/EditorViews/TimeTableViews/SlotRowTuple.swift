//
//  SlotRowTupleswift
//  TimeTable
//
//  Created by Alexander Gertsch on 25.12.21.
//

import SwiftUI

struct SlotRowTuple: View {
    let day: Day
    let slots: [Slot]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 0) {
                    ForEach(slots) {slot in
                        SlotRow(for: Meeting(on: day, in: slot))
                            .frame(height: geometry.size.height / CGFloat(slots.count))
                    }
                }
                Rectangle().stroke(lineWidth: EditorDrawingConstants.thickLineWidth)
            }
            
        }
    }
    
    init(on day: Day, for slots: [Slot]) {
        self.day = day
        self.slots = slots
    }
}
