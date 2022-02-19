//
//  FieldDropChecker.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 30.12.21.
//

import SwiftUI

struct FieldDropChecker {
    
    static func dropAllowed(for movingLesson: Lesson, on field: TimeTableField) -> Bool {
        // unwrap the movingLesson (if not possible: return false)
        //if let movingLesson = field.editor.movingLesson,
        
        // further: movingLesson must have same promotion as field {
        if movingLesson.promotion == field.promotion {
            
            // further: if the movingLesson starts from the field itself, dropping is forbidden
            if let meeting = movingLesson.isScheduledOn,
               meeting == field.meeting {
                return false
            }
            
            // field must not contain a fullClasslesson to perform a drop
            if field.oneAndOnlyFullClassLesson == nil,
               
               // further: teachers mustn't have cancelled this field's time
               timeNotCancelledByTeachers(in: movingLesson, for: field) {
                
                // further: we switch on the movingLessons kind
                switch movingLesson.kind {
                case .full:
                    return dropAllowedForMovingFullClassLesson(movingLesson, in: field)
                case .half(let movingType):
                    return dropAllowedForMovingHalfClassLesson(movingLesson, of: movingType, in: field)
                case .instrumental(let movingDuration):
                    return dropAllowedForMovingInstrumentalLesson(movingLesson, with: movingDuration, in: field)
                }
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    // check whether (day,time) of field isn't cancelled by teacher(s) of movingLesson
    static func timeNotCancelledByTeachers(in movingLesson: Lesson, for field: TimeTableField) -> Bool {
        for teacher in movingLesson.teachers {
            let impossibilities = TeacherData.getImpossibilities(for: teacher)
            if impossibilities.contains(where: { $0 == field.meeting } ) {
                return false
            }
        }
        return true
    }
    
    static func dropAllowedForMovingFullClassLesson(_ fullClassLesson: Lesson, in field: TimeTableField) -> Bool {
        field.lessons.isEmpty
    }
    
    static func dropAllowedForMovingHalfClassLesson(_ movingLesson: Lesson, of movingType: Lesson.HalfClassType, in field: TimeTableField) -> Bool {
        for localLesson in field.halfClassLessons {
            switch localLesson.kind {
            case .half(let localType):
                switch localType {
                case .basic:
                    if localType == movingType,
                       localLesson.subject == movingLesson.subject {
                        return false
                    }
                case .focus:
                    if localType == movingType,
                       localLesson.subject == movingLesson.subject {
                        return false
                    }
                case .ef, .free:
                    return true
                default:
                    if localType == movingType {
                        return false
                    }
                }
            default: return false
            }
        }
        return true
    }
    
    static func dropAllowedForMovingInstrumentalLesson(_ movingLesson: Lesson, with movingDuration: Lesson.Duration, in field: TimeTableField) -> Bool {
        let teacher = movingLesson.teachers.first!
        var timeSum = 0
        switch movingDuration {
        case .full: timeSum += 2
        case .half: timeSum += 1
        default: print("instrumental lesson with unknown duration found!")
        }
        let lessonsOfTeacher = field.instrumentalLessons.filter({ $0.teachers.first! == teacher })
        for lesson in lessonsOfTeacher {
            switch lesson.kind {
            case .instrumental(let localDuration):
                switch localDuration {
                case .full: timeSum += 2
                case .half: timeSum += 1
                default: print("instrumental lesson with unknown duration found!")
                }
            default: return false
            }
            if timeSum > 2 { return false }
        }
        return true
    }
       
}
