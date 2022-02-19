//
//  DayHeader.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 25.12.21.
//

import SwiftUI

struct DayHeader: View {
    let day: Day
    
    var body: some View {
        GeometryReader { geometry in
            let headerHeight = geometry.size.height
            let promotionWidth = geometry.size.width / CGFloat(Promotion.numberOfPromotions)
            VStack(alignment: .leading, spacing: 0) {
                Text(day.rawValue)
                    .labelify(with: DrawingConstants.dayFontScaleFactor)
                    .frame(height: DrawingConstants.dayLabelHeight(for: headerHeight))
                HStack(spacing: 0) {
                    ForEach(Promotion.allCases) { promotion in
                        Text(promotion.displayed)
                            .labelify(with: DrawingConstants.promotionFontScaleFactor)
                            .frame(
                                width: promotionWidth,
                                height: DrawingConstants.promotionLabelHeight(for: headerHeight))
                    }
                }
            }
        }
    }
    
    init(for day: Day) { self.day = day }
    
    private struct DrawingConstants {
        static let dayLabelToHeaderHeight: CGFloat = 0.6
        static let dayFontScaleFactor: CGFloat = 0.7
        static let promotionFontScaleFactor: CGFloat = 0.7
        
        static func dayLabelHeight(for headerHeight: CGFloat) -> CGFloat {
            headerHeight * DrawingConstants.dayLabelToHeaderHeight
        }
        
        static func promotionLabelHeight(for headerHeight: CGFloat) -> CGFloat {
            headerHeight - dayLabelHeight(for: headerHeight)
        }
    }
}
