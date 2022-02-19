//
//  Meeting.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 06.02.22.
//

import Foundation

struct Meeting: Equatable {
    var day: Day
    var slot: Slot
    
    init(on day: Day, in slot: Slot) {
        self.day = day
        self.slot = slot
    }
}
