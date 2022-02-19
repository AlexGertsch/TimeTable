//
//  SlotRow.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 25.12.21.
//

import SwiftUI

struct SlotRow: View {
    let meeting: Meeting
    
    var body: some View {
        GeometryReader { geometry in
            let promotionWidth = geometry.size.width / CGFloat(Promotion.numberOfPromotions)
            HStack(spacing: 0) {
                ForEach(Promotion.allCases) { promotion in
                    TimeTableField(for: promotion, and: meeting)
                        .frame(width: promotionWidth)
                }
            }
        }
    }
    
    init(for meeting: Meeting) {
        self.meeting = meeting
    }
    
}
