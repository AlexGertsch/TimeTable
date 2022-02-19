//
//  SemesterDays.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 30.01.22.
//

import Foundation

struct SemesterDays {
    static let firstQuarter: [DayDate] =
    [
        // Kalenderwoche 9: mündl. Aufnahmeprüfungen Mo+Di
        // DayDate(.monday,28,2,2022, false),
        // DayDate(.tuesday,1,3,2022),
        DayDate(.wednesday,2,3,2022,false),
        DayDate(.thursday,3,3,2022,false),
        DayDate(.friday,4,3,2022,false),
        
        // Kalenderwoche 10
        DayDate(.monday,7,3,2022,false),
        DayDate(.tuesday,8,3,2022,false),
        DayDate(.wednesday,9,3,2022,false),
        DayDate(.thursday,10,3,2022,false),
        DayDate(.friday,11,3,2022,false),
        
        // Kalenderwoche 11
        DayDate(.monday,14,3,2022,false),
        DayDate(.tuesday,15,3,2022,false),
        DayDate(.wednesday,16,3,2022,false),
        DayDate(.thursday,17,3,2022,false),
        DayDate(.friday,18,3,2022,false),
        
        // Kalenderwoche 12
        DayDate(.monday,21,3,2022,false),
        DayDate(.tuesday,22,3,2022,false),
        DayDate(.wednesday,23,3,2022,false),
        DayDate(.thursday,24,3,2022,false),
        DayDate(.friday,25,3,2022,false),
        
        // Kalenderwoche 13
        DayDate(.monday,28,3,2022,false),
        DayDate(.tuesday,29,3,2022,false),
        DayDate(.wednesday,30,3,2022,false),
        DayDate(.thursday,31,3,2022,false),
        DayDate(.friday,1,4,2022,false),
        
        // Kalenderwoche 14
        DayDate(.monday,4,4,2022,false),
        DayDate(.tuesday,5,4,2022,false),
        DayDate(.wednesday,6,4,2022,false),
        DayDate(.thursday,7,4,2022,false),
        DayDate(.friday,8,4,2022,false),
        
        // Kalenderwoche 15: Karfreitag
        DayDate(.monday,11,4,2022,false),
        DayDate(.tuesday,12,4,2022,false),
        DayDate(.wednesday,13,4,2022,false),
        DayDate(.thursday,14,4,2022,false),
        // DayDate(.friday,15,4,2022,false),
        
        // Kalenderwoche 16: Frühlingsferien Woche 1
        // Kalenderwoche 17: Frühlingsferien Woche 2
    ]
    
    static let secondQuarter: [DayDate] =
    [
        // Kalenderwoche 18
        DayDate(.monday,2,5,2022,false),
        DayDate(.tuesday,3,5,2022,false),
        DayDate(.wednesday,4,5,2022,false),
        DayDate(.thursday,5,5,2022,false),
        DayDate(.friday,6,5,2022,false),
        
        // Kalenderwoche 19
        DayDate(.monday,9,5,2022,false),
        DayDate(.tuesday,10,5,2022,false),
        DayDate(.wednesday,11,5,2022,false),
        DayDate(.thursday,12,5,2022,false),
        DayDate(.friday,13,5,2022,false),
        
        // Kalenderwoche 20
        DayDate(.monday,16,5,2022,true),
        DayDate(.tuesday,17,5,2022,true),
        DayDate(.wednesday,18,5,2022,true),
        DayDate(.thursday,19,5,2022,true),
        DayDate(.friday,20,5,2022,true),
        
        // Kalenderwoche 21: Auffahrt + Brücke
        DayDate(.monday,23,5,2022,true),
        DayDate(.tuesday,24,5,2022,true),
        DayDate(.wednesday,25,5,2022,true),
        // DayDate(.thursday,26,5,2022,true),
        // DayDate(.friday,27,5,2022,true),
        
        // Kalenderwoche 22
        DayDate(.monday,30,5,2022,true),
        DayDate(.tuesday,31,5,2022,true),
        DayDate(.wednesday,1,6,2022,true),
        DayDate(.thursday,2,6,2022,true),
        DayDate(.friday,3,6,2022,true),
        
        // Kalenderwoche 23: Pfingstmontag
        // DayDate(.monday,6,6,2022,true),
        DayDate(.tuesday,7,6,2022,true),
        DayDate(.wednesday,8,6,2022,true),
        DayDate(.thursday,9,6,2022,true),
        DayDate(.friday,10,6,2022,true),
        
        // Kalenderwoche 24
        DayDate(.monday,13,6,2022,true),
        DayDate(.tuesday,14,6,2022,true),
        DayDate(.wednesday,15,6,2022,true),
        DayDate(.thursday,16,6,2022,true),
        DayDate(.friday,17,6,2022,true),
        
        // Kalenderwoche 25
        DayDate(.monday,20,6,2022,true),
        DayDate(.tuesday,21,6,2022,true),
        DayDate(.wednesday,22,6,2022,true),
        DayDate(.thursday,23,6,2022,true),
        DayDate(.friday,24,6,2022,true)
    ]
    
    static let wholeSemester: [DayDate] = firstQuarter + secondQuarter
    
    static func dayDates(for chosenWeekday: Day, in semesterPart: [DayDate]) -> [DayDate] {
        semesterPart.filter( { $0.weekday == chosenWeekday } )
    }
    
    static func dayDatesForMaturaClasses(for chosenWeekday: Day, in semesterPart: [DayDate]) -> [DayDate] {
        semesterPart.filter( { $0.weekday == chosenWeekday && !$0.matura } )
    }
    
    struct DayDate {
        var weekday: Day  // Wochentag
        var day: Int      // Tag
        var month: Int    // Monat
        var year: Int     // Jahr
        var matura: Bool  // Matura-Vorbereitungs- oder -Prüfungswoche?
        
        init(
            _ weekday: Day,
            _ day: Int,
            _ month: Int,
            _ year: Int,
            _ matura: Bool
        ) {
            assert(day > 0 && day < 32, "day not in [1;31]")
            assert(month > 0 && month < 13, "month not in [1;12]")
            assert(year > 2021 && year < 2031, "year not in [2022;2030]")
            self.weekday = weekday
            self.day = day
            self.month = month
            self.year = year
            self.matura = matura
        }
    }
}
