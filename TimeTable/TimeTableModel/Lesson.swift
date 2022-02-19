//
//  Lesson.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 21.12.21.
//

import Foundation

struct Lesson: Identifiable {
    var id: String
    
    let promotion: Promotion
    var firstOfMultiplePromotions: Bool = true
    let subject: Subject
    var kind: Kind
    let teachers: [TeacherData.id]
    var versionNumber: Int = 1
    var instrumentalIndex: Int?
    var freeInstrumental: Bool?
    var instrumentalPlacing: InstrumentalPlacing = .early
    var instrumentalSex: Sex?
    var onlyQuarter: Quarter?
    
    var isScheduledOn: Meeting?
    var room: Room?
    
    // MARK: - additional enums
    
    enum Kind: Equatable {
        case full
        case half(HalfClassType)
        case instrumental(Duration)
        
        var minutes: Int {
            switch self {
            case .instrumental(let duration):
                switch duration {
                case .half: return 22
                default: return 45
            }
            default: return 45
            }
        }
    }
    
    enum HalfClassType: String {
        case x
        case y
        case z
        case basic    // basic class = Grundlagenfach
        case focus    // focus class = Schwerpunktfach
        case focus1   // focus class with teacher 1
        case focus2   // focus class with teacher 2
        case ef       // Ergänzungsfach
        case free
        
        var displayed: String {
            switch self {
            case .x: return "X"
            case .y: return "Y"
            case .z: return "Z"
            case .basic: return "GF"
            case .focus: return "SP"
            case .focus1: return "SP1"
            case .focus2: return "SP2"
            case .ef: return "EF"
            case .free: return "FF"
            }
        }
        
        var exported: String {
            switch self {
            case .x: return "-X"
            case .y: return "-Y"
            case .z: return "-Z"
            case .focus: return "SP"
            case .focus1: return "SP1"
            case .focus2: return "SP2"
            default: return ""
            }
        }
    }
    
    enum Duration {
        case half
        case full
        case unknown
    }
    
    enum InstrumentalPlacing: Codable {
        case early
        case late
    }
    
    enum Quarter {
        case first
        case second
    }
    
    // MARK: - initalizers
    
    // initializer for full- and halfClassLessons
    init(
        promotion: Promotion,
        firstOfMultiplePromotions: Bool,
        subject: Subject,
        halfClassType: HalfClassType?,
        teachers: [TeacherData.id],
        versionNumber: Int,
        onlyQuarter: Quarter?
    ) {
        self.promotion = promotion
        self.firstOfMultiplePromotions = firstOfMultiplePromotions
        self.subject = subject
        self.teachers = teachers
        self.versionNumber = versionNumber
        self.onlyQuarter = onlyQuarter
        var idUnderConstruction = promotion.rawValue + "-" + subject.rawValue + "-"
        if let type = halfClassType {
            kind = .half(type)
            idUnderConstruction += type.rawValue + "-"
        } else {
            kind = .full
        }
        idUnderConstruction += String(versionNumber) + "-"
        for teacher in teachers {
            idUnderConstruction += teacher.rawValue
        }
        if teachers.count == 1 {
            self.room = TeacherData.personalData(for: teachers.first!).defaultRoom
        } else if let subjectRoom = subject.defaultRoom {
            self.room = subjectRoom
        }
        self.id = idUnderConstruction
    }
    
    // initializer for instrumentalLessons
    init(
        lastName: String,
        firstName: String,
        promotion: Promotion,
        instrument: (subject: Subject, teacher: TeacherData.id, duration: Lesson.Duration),
        instrumentalIndex: Int,
        freeInstrumental: Bool,
        instrumentalSex: Sex
    ) {
        self.promotion = promotion
        assert(
            Subject.allInstruments.contains(instrument.subject),
            "Lesson.init: instrumentalLesson-Initializer called for non-instrumental subject!"
        )
        self.subject = instrument.subject
        self.kind = .instrumental(instrument.duration)
        self.teachers = [instrument.teacher]
        self.room = TeacherData.personalData(for: teachers.first!).defaultRoom
        self.instrumentalIndex = instrumentalIndex
        self.freeInstrumental = freeInstrumental
        self.instrumentalSex = instrumentalSex
        self.id = lastName + "-" + firstName + "-" + promotion.rawValue + "-" + subject.rawValue + "-" + instrument.teacher.rawValue
    }
    
}
