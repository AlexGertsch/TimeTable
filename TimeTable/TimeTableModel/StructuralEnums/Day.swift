//
//  Day.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 21.12.21.
//

import Foundation

enum Day: String, CaseIterable, Identifiable, Codable {
    var id: Day { self }
    
    case monday = "Montag"
    case tuesday = "Dienstag"
    case wednesday = "Mittwoch"
    case thursday = "Donnerstag"
    case friday = "Freitag"
    
    static var firstFourDays: [Day] {
        Day.allCases.dropLast(1)
    }
}
