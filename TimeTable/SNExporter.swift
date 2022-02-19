//
//  SNExporter.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 05.02.22.
//

import Foundation

struct SNExporter {
    var editor: TimeTableEditor
    
    var allDayDatesFor = [Day:[SemesterDays.DayDate]]()
    var allMaturaClassDayDatesFor = [Day:[SemesterDays.DayDate]]()
    var firstQuarterDayDatesFor = [Day:[SemesterDays.DayDate]]()
    var secondQuarterDayDatesFor = [Day:[SemesterDays.DayDate]]()
    
    var instrumentalsToExport = [Lesson]()
    var bgSpecialCasesToExport = [Lesson]()
    var freesToExport = [Lesson]()
    
    init(for editor: TimeTableEditor) {
        self.editor = editor
        for day in Day.allCases {
            self.allDayDatesFor[day] = SemesterDays.dayDates(for: day, in: SemesterDays.wholeSemester)
            self.allMaturaClassDayDatesFor[day] = SemesterDays.dayDatesForMaturaClasses(for: day, in: SemesterDays.wholeSemester)
            self.firstQuarterDayDatesFor[day] = SemesterDays.dayDates(for: day, in: SemesterDays.firstQuarter)
            self.secondQuarterDayDatesFor[day] = SemesterDays.dayDates(for: day, in: SemesterDays.secondQuarter)
        }
    }
    
    mutating func sNExport() {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd.HH.mm"
        let actualDate = formatter.string(from: now)
        
        let filename = "ExportDocs/Export_" + actualDate + ".txt"
        
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        if let url = documentDirectory?.appendingPathComponent(filename) {
            let text = exportString()
            do {
                try text.write(to: url, atomically: true, encoding: .utf8)
            } catch { print("Couldn't write the file!") }
        }
    }
    
    mutating private func exportString() -> String {
        var exportString = ""
        
        // preparation of different lesson groups for the export
        // the lessons need to be set and in case of multiple promotions
        // participating only the lessons of the first promotion are exported,
        // since the participating promotions are newly added in sN
        let lessonsToExport = editor.lessons.filter {
            //$0.isScheduledOn != nil &&
            $0.firstOfMultiplePromotions
        }
        
        for lesson in lessonsToExport {
            switch lesson.kind {
            case .full:
                exportString += regularClassExportStrings(for: lesson)
            case .half(let halfClassType):
                if halfClassType == .free {
                    freesToExport.append(lesson)
                }
                else {
                    exportString += regularClassExportStrings(for: lesson)
                }
            case .instrumental(_): instrumentalsToExport.append(lesson)
            }
        }
        
        // the exportStrings for instrumentalLessons are exported teacher by teacher
        for instrumentalTeacher in TeacherData.instrumentalTeachers {
            exportString += instrumentalExportStrings(for: instrumentalTeacher)
        }
        
        exportString += freeExportStrings()
        
        return exportString
    }
    
    private func regularClassExportStrings(for lesson: Lesson) -> String {
        var regularClassExportStrings = ""
        if lesson.promotion.isMaturaClass {
            if let meeting = lesson.isScheduledOn {
                for lessonDate in allMaturaClassDayDatesFor[lesson.isScheduledOn!.day]! {
                    regularClassExportStrings += regularClassExportString(for: lesson, on: lessonDate, in: meeting)
                }
            }
        } else {
            if let quarter = lesson.onlyQuarter {
                switch quarter {
                case .first:
                    if let meeting = lesson.isScheduledOn {
                        for lessonDate in firstQuarterDayDatesFor[lesson.isScheduledOn!.day]! {
                            regularClassExportStrings += regularClassExportString(for: lesson, on: lessonDate, in: meeting)
                        }
                    }
                case .second:
                    if let meeting = secondQuarterMeeting(for: lesson) {
                        for lessonDate in secondQuarterDayDatesFor[meeting.day]! {
                            regularClassExportStrings += regularClassExportString(for: lesson, on: lessonDate, in: meeting)
                        }
                    }
                }
            } else {
                if let meeting = lesson.isScheduledOn {
                    for lessonDate in allDayDatesFor[lesson.isScheduledOn!.day]! {
                        regularClassExportStrings += regularClassExportString(for: lesson, on: lessonDate, in: meeting)
                    }
                }
            }
        }
        return regularClassExportStrings
    }

    private func regularClassExportString(for lesson: Lesson, on lessonDate: SemesterDays.DayDate, in meeting: Meeting) -> String {
        var newRegularClassExportString = ""
        // add teacher
        if let teacher = lesson.teachers.first {
            newRegularClassExportString += teacher.rawValue
        }
        newRegularClassExportString += ","
        
        // add date-entry
        newRegularClassExportString += String(lessonDate.year) + ","
        newRegularClassExportString += String(lessonDate.month) + ","
        newRegularClassExportString += String(lessonDate.day) + ","
        
        // add weekday-number
        switch meeting.day {
        case .monday: newRegularClassExportString += "1,"
        case .tuesday: newRegularClassExportString += "2,"
        case .wednesday: newRegularClassExportString += "3,"
        case .thursday: newRegularClassExportString += "4,"
        case .friday: newRegularClassExportString += "5,"
        }
        
        // add subject-shortct
        // handle the Sp-T-exception for Magna classes
        if lesson.subject == .T, lesson.promotion.classChar == "c" {
            newRegularClassExportString += "Sp-T"
        } else {
            newRegularClassExportString += lesson.subject.rawValue
            switch lesson.kind {
            // handle the PPP-exception for declarations of teachers and no SP in focus-subject-title
            case .half(let halfClassType):
                if lesson.subject != .PPP {
                    newRegularClassExportString += halfClassType.exported
                }
            case .full:
                if lesson.subject == .PPP {
                    if lesson.teachers.first == .SM {
                        newRegularClassExportString += "1"
                    } else if lesson.teachers.first == .SU {
                        newRegularClassExportString += "2"
                    }
                }
            default: break
            }
        }
        newRegularClassExportString += ","
        
        // add classString
        newRegularClassExportString += lesson.promotion.displayed + ","
        
        // add room
        if let room = lesson.room {
            newRegularClassExportString += room.rawValue + ","
        } else {
            newRegularClassExportString += "k.A.,"
        }
        
        // comma-pause
        newRegularClassExportString += ",,,"
        
        // add startTimeString
        newRegularClassExportString += meeting.slot.startExportString + ","
        
        // add duration
        newRegularClassExportString += String(lesson.kind.minutes) + ","

        // add linebreak
        newRegularClassExportString += "\n"

        return newRegularClassExportString
    }
    
    // MARK: - instrumental classes
    
    mutating private func instrumentalExportStrings(for teacher: TeacherData.id) -> String {
        var instrumentalTeacherExportStrings = ""
        let lessonsOfTeacher = instrumentalsToExport.filter { $0.teachers.first! == teacher }
        for instrumentalLesson in lessonsOfTeacher {
            instrumentalTeacherExportStrings += instrumentalExportStrings(for: instrumentalLesson)
        }
        return instrumentalTeacherExportStrings
    }
    
    mutating private func instrumentalExportStrings(for lesson: Lesson) -> String {
        var instrumentalExportStrings = ""
        for lessonDate in allDayDatesFor[lesson.isScheduledOn!.day]! {
            instrumentalExportStrings += instrumentalExportString(for: lesson, on: lessonDate)
        }
        return instrumentalExportStrings
    }
    
    mutating private func instrumentalExportString(for lesson: Lesson, on lessonDate: SemesterDays.DayDate) -> String {
        var newInstrumentalExportString = ""
        
        // add teacher
        if let teacher = lesson.teachers.first {
            newInstrumentalExportString += teacher.rawValue
        }
        newInstrumentalExportString += ","
            
        // add date-entry
        newInstrumentalExportString += String(lessonDate.year) + ","
        newInstrumentalExportString += String(lessonDate.month) + ","
        newInstrumentalExportString += String(lessonDate.day) + ","
            
        // add weekday-number
        switch lesson.isScheduledOn!.day {
        case .monday: newInstrumentalExportString += "1,"
        case .tuesday: newInstrumentalExportString += "2,"
        case .wednesday: newInstrumentalExportString += "3,"
        case .thursday: newInstrumentalExportString += "4,"
        case .friday: newInstrumentalExportString += "5,"
        }
            
        // add name of additional class
        newInstrumentalExportString += lesson.subject.rawValue + "-"
        newInstrumentalExportString += lesson.promotion.displayed + "\(lesson.instrumentalIndex!)"
        if let free = lesson.freeInstrumental, free {
            newInstrumentalExportString += "f"
        }
        newInstrumentalExportString += "-" + lesson.teachers.first!.rawValue + ","
            
        // add classString
        newInstrumentalExportString += lesson.promotion.displayed + ","
            
        // add room
        if let room = lesson.room {
            newInstrumentalExportString += room.rawValue + ","
        } else {
            newInstrumentalExportString += "k.A.,"
        }
            
        // comma-pause
        newInstrumentalExportString += ",,,"
            
        // add startTimeString
        switch lesson.kind {
        case .instrumental(let duration):
            if duration == .full {
                newInstrumentalExportString += lesson.isScheduledOn!.slot.startExportString + ","
            } else if duration == .half {
                if lesson.instrumentalPlacing == .early {
                    newInstrumentalExportString += lesson.isScheduledOn!.slot.startExportString + ","
                } else {
                    newInstrumentalExportString += lesson.isScheduledOn!.slot.lateStartExportString + ","
                }
            }
        default: break
        }
            
        // add duration
        newInstrumentalExportString += String(lesson.kind.minutes) + ","

        // add linebreak
        newInstrumentalExportString += "\n"

        return newInstrumentalExportString
    }
    
    // MARK: - generate ffExportStrings
    
    private func freeExportStrings() -> String {
        var newFreeExportStrings = ""
        for freeLesson in freesToExport {
            for lessonDate in allDayDatesFor[freeLesson.isScheduledOn!.day]! {
                newFreeExportStrings += freeExportString(for: freeLesson, on: lessonDate)
            }
        }
        return newFreeExportStrings
    }
    
    private func freeExportString(for lesson: Lesson, on lessonDate: SemesterDays.DayDate) -> String {
        var newFreeExportString = ""
        
        // add teacher
        if let teacher = lesson.teachers.first {
            newFreeExportString += teacher.rawValue
        }
        newFreeExportString += ","
            
        // add date-entry
        newFreeExportString += String(lessonDate.year) + ","
        newFreeExportString += String(lessonDate.month) + ","
        newFreeExportString += String(lessonDate.day) + ","
            
        // add weekday-number
        switch lesson.isScheduledOn!.day {
        case .monday: newFreeExportString += "1,"
        case .tuesday: newFreeExportString += "2,"
        case .wednesday: newFreeExportString += "3,"
        case .thursday: newFreeExportString += "4,"
        case .friday: newFreeExportString += "5,"
        }
            
        // add name of additional class
        newFreeExportString += lesson.subject.exported + "-"
        newFreeExportString += lesson.teachers.first!.rawValue
        if lesson.teachers.count > 1 {
            for index in 1..<lesson.teachers.count {
                newFreeExportString += "+" + lesson.teachers[index].rawValue
            }
        }
        newFreeExportString += ","
            
        // add classString
        newFreeExportString += lesson.promotion.displayed + ","
            
        // add room
        if let room = lesson.room {
            newFreeExportString += room.rawValue + ","
        } else {
            newFreeExportString += "k.A.,"
        }
            
        // comma-pause
        newFreeExportString += ",,,"
            
        // add startTimeString
        newFreeExportString += lesson.isScheduledOn!.slot.startExportString + ","
            
        // add duration
        newFreeExportString += String(lesson.kind.minutes) + ","

        // add linebreak
        newFreeExportString += "\n"

        return newFreeExportString
    }
    
    // MARK: - special alterations
    
    private func secondQuarterMeeting(for lesson: Lesson) -> Meeting? {
        let promotionsWithSecondQuarterOnlyLessons = Promotion.allCases.filter { $0.classNumber == 3 }
        if promotionsWithSecondQuarterOnlyLessons.contains(lesson.promotion) {
            switch lesson.subject {
            case .B:
                switch lesson.kind {
                case .half(let halfClassType):
                    switch halfClassType {
                    case .x:
                        if lesson.promotion == .p151a {
                            if lesson.versionNumber == 1 {
                                return Meeting(on: .tuesday, in: .morning5)
                            } else if lesson.versionNumber == 2 {
                                return Meeting(on: .tuesday, in: .noon1)
                            }
                        } else if lesson.promotion == .p151b {
                            if lesson.versionNumber == 1 {
                                return Meeting(on: .monday, in: .afternoon1)
                            } else if lesson.versionNumber == 2 {
                                return Meeting(on: .monday, in: .afternoon2)
                            }
                        }
                    case .y:
                        if lesson.promotion == .p151a {
                            if lesson.versionNumber == 1 {
                                return Meeting(on: .wednesday, in: .morning5)
                            } else if lesson.versionNumber == 2 {
                                return Meeting(on: .wednesday, in: .noon1)
                            }
                        } else if lesson.promotion == .p151b {
                            if lesson.versionNumber == 1 {
                                return Meeting(on: .monday, in: .afternoon3)
                            } else if lesson.versionNumber == 2 {
                                return Meeting(on: .monday, in: .afternoon4)
                            }
                        }
                    default: break
                    }
                default: break
                }
            case .Ph:
                if lesson.promotion == .p151a {
                    if lesson.versionNumber == 1 {
                        return Meeting(on: .monday, in: .afternoon1)
                    } else if lesson.versionNumber == 2 {
                        return Meeting(on: .monday, in: .afternoon2)
                    }
                } else if lesson.promotion == .p151b {
                    if lesson.versionNumber == 1 {
                        return Meeting(on: .tuesday, in: .morning5)
                    } else if lesson.versionNumber == 2 {
                        return Meeting(on: .tuesday, in: .noon1)
                    }
                }
            case .IP2:
                if lesson.versionNumber == 1 {
                    return Meeting(on: .tuesday, in: .morning5)
                } else if lesson.versionNumber == 2 {
                    return Meeting(on: .tuesday, in: .noon1)
                }
            default: break
            }
        }
        return nil
    }
    
    
}
