//
//  MainReserve.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 26.12.21.
//

import SwiftUI

struct MainReserve: View {
    @EnvironmentObject var editor: TimeTableEditor
    
    var body: some View {
        let reserveDropDelegate = ReserveDropDelegate(editor: editor)
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(EditorDrawingConstants.colorForAllowedDropping)
                    .opacity(0)
                arrangeReserves()
            }
            .onDrop(of: [.utf8PlainText], delegate: reserveDropDelegate)
        }
    }
    
    private func arrangeReserves() -> some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(Promotion.allCases) { promotion in
                    PromotionReserve(for: promotion)
                        .frame(width: promotionWidth(for: geometry.size))
                    Spacer(minLength: promotionSpacerWidth(for: geometry.size))
                }
                InstrumentalReserve()
                    .frame(width: instrumentalWidth(for: geometry.size))
            }
        }
    }
    
    struct ReserveDropDelegate: DropDelegate {
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
                        if let movedLesson = editor.movingLesson {
                            editor.remove(movedLesson)
                        }
                        editor.movingLesson = nil
                    }
                }
                return true
            }
            return false
        }
    }
    
    // MARK: - drawing calculations
    
    private func promotionToWidth() -> CGFloat {
        (1 - EditorDrawingConstants.instrumentalReserveToWidth
         - CGFloat(Promotion.numberOfPromotions) * EditorDrawingConstants.promotionSpacerToWidth)
        / CGFloat(Promotion.numberOfPromotions)
    }
    
    private func instrumentalWidth(for size: CGSize) -> CGFloat {
        EditorDrawingConstants.instrumentalReserveToWidth * size.width
    }
    
    private func promotionSpacerWidth(for size: CGSize) -> CGFloat {
        EditorDrawingConstants.promotionSpacerToWidth * size.width
    }
    
    private func promotionWidth(for size: CGSize) -> CGFloat {
        promotionToWidth() * size.width
    }
}

