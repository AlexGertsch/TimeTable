//
//  TimeTable.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 21.12.21.
//

import Foundation

struct TimeTable {
    private(set) var lessons: [Lesson]
    
    init() {
        TimeTable.lessonDataChecks()
        TimeTable.pupilDataChecks()
        var newLessons = TimeTable.initializeClassLessonsFromLessonData()
        newLessons += TimeTable.initializeInstrumentalLessonsFromPupilData()
        newLessons += TimeTable.initializeFreesFromPupilAndLessonData()
        lessons = newLessons
    }
    
    // MARK: - filter funcs to access the lessons-array
    
    func lessons(for promotion: Promotion) -> [Lesson] {
        lessons.filter { $0.promotion == promotion }
    }
    
    func lessons(for promotion: Promotion, and meeting: Meeting) -> [Lesson] {
        var lessonsToReturn = lessons(for: promotion).filter { $0.isScheduledOn != nil }
        lessonsToReturn = lessonsToReturn.filter { $0.isScheduledOn! == meeting }
        return lessonsToReturn
    }
    
    func lesson(for id: String) -> Lesson? {
        for lesson in lessons {
            if lesson.id == id {
                return lesson
            }
        }
        print("TimeTable.lesson(for: id) didn't find a lesson with id: \(id)")
        return nil
    }
    
    // MARK: - mutating funcs for the lessons-array
    
    mutating func put(_ lesson: Lesson, on meeting: Meeting) {
        if let chosenIndex = lessons.firstIndex(where: { $0.id == lesson.id }) {
            lessons[chosenIndex].isScheduledOn = meeting
            
            // if an instrumental lesson was moved, check, whether there is another lesson of the
            // same teacher in the same meeting. If there is, put the moved lesson late in the
            // slot and the other lesson early in the slot.
            switch lessons[chosenIndex].kind {
            case .instrumental(_):
                let otherLessonsInMeeting = lessons.filter { $0.isScheduledOn == meeting && $0.id != lesson.id }
                let otherLessonOfInstrumentalTeacherInMeeting = otherLessonsInMeeting.filter { $0.teachers.first == lesson.teachers.first }
                if let otherLesson = otherLessonOfInstrumentalTeacherInMeeting.first {
                    if let otherLessonIndex = lessons.firstIndex(where: { $0.id == otherLesson.id }) {
                        lessons[otherLessonIndex].instrumentalPlacing = .early
                        lessons[chosenIndex].instrumentalPlacing = .late
                    }
                } else {
                    lessons[chosenIndex].instrumentalPlacing = .early
                }
            default: break
            }
        }
    }
    
    mutating func remove(_ lesson: Lesson) {
        if let chosenIndex = lessons.firstIndex(where: { $0.id == lesson.id }) {
            lessons[chosenIndex].isScheduledOn = nil
        } else {
            print("Lesson not found in lesson-array!")
        }
    }
    
    mutating func changeRoom(of lesson: Lesson, to room: Room?) {
        if let chosenIndex = lessons.firstIndex(where: { $0.id == lesson.id }) {
            lessons[chosenIndex].room = room
        }
    }
    
    // MARK: - storage functionality
    
    func json() throws -> Data {
        return try JSONEncoder().encode(lessonInfos)
    }
    
    init(json: Data) throws {
        self.init()
        let earlierLessonInfos = try JSONDecoder().decode([LessonInfo].self, from: json)
        applyStoredData(in: earlierLessonInfos)
    }
    
    init(url: URL) throws {
        let data = try Data(contentsOf: url)
        self = try TimeTable(json: data)
    }
    
    var lessonInfos: [LessonInfo] {
        var newLessonInfos = [LessonInfo]()
        let scheduledLessons = lessons.filter { $0.isScheduledOn != nil }
        for lesson in scheduledLessons {
            newLessonInfos.append(LessonInfo(for: lesson))
        }
        return newLessonInfos
    }
    
    struct LessonInfo: Codable {
        var id: String
        var day: Day
        var slot: Slot
        var room: Room?
        var instrumentalPlacing: Lesson.InstrumentalPlacing
        
        init(for lesson: Lesson) {
            self.id = lesson.id
            assert(lesson.isScheduledOn != nil, "TimeTable.EncodedLesson tried to encode unscheduled Lesson \(lesson.id)")
            self.day = lesson.isScheduledOn!.day
            self.slot = lesson.isScheduledOn!.slot
            self.room = lesson.room
            self.instrumentalPlacing = lesson.instrumentalPlacing
        }
    }
    
    mutating func applyStoredData(in earlierLessonInfos: [LessonInfo]) {
        for lessonInfo in earlierLessonInfos {
            if let index = lessons.firstIndex(where: { $0.id == lessonInfo.id }) {
                lessons[index].isScheduledOn = Meeting(on: lessonInfo.day, in: lessonInfo.slot)
                lessons[index].room = lessonInfo.room
                lessons[index].instrumentalPlacing = lessonInfo.instrumentalPlacing
            }
        }
    }
    
    // MARK: - funcs for initialization
    
    private static func lessonDataChecks() {
        for data in LessonData.lessonDefinitions {
            // each lessonData must contain one ore more appearances per week
            assert(data.lessonsPerWeek > 0,
                   "TimeTable init: lessonData doesn't contain one or more appearances per week")
            
            // each lessonData must have at least one promotion specified
            assert(!data.promotions.isEmpty,
                   "TimeTable init: lessonData has no promotion(s) specified")
        }
    }
    
    private static func pupilDataChecks() {
        for data in PupilData.pupilDefinitions {
            // check if c-class-pupil has focus NW
            if data.promotion.classChar == "c" {
                assert(data.focus == .nw,
                       "TimeTable.init.basicPupilChecks: c-class-pupil hasn't focus NW assigned!")
            }
            
            // check if a/b-first-class-pupils has no focus assigned
            if data.promotion.classChar == "a" || data.promotion.classChar == "b", data.promotion.classNumber == 1 {
                assert(data.focus == nil,
                       "a/b-first-class-pupil has a focus assigned!")
            }
            
            // check if there is at least one instrumentalLesson if necessary
            switch data.focus {
            case .bg:
                if data.promotion.classNumber < 4 {
                    assert(!data.instruments.isEmpty,
                           "TimeTable.init: first to third class BG-pupil has no instrument assigned!")
                }
            case .mu:
                assert(!data.instruments.isEmpty,
                       "TimeTable.init: Mu-pupil has no instrument assigned!")
                // check if a fourth-class-pupil with focus Mu has a full principal instrumental lesson
                if data.promotion.classNumber == 4 {
                    assert(data.instruments.first!.duration == .full,
                           "TimeTable.init: fourth class Mu-pupil has no full principal instrumental lesson!")
                }
            case .nw:
                // check if NW-pupil is in a c-class
                assert(data.promotion.classChar == "c",
                       "TimeTable.init: NW-pupil assigned to non-c-class!")
            case .ppp:
                break
            case nil:
                assert(!data.instruments.isEmpty,
                       "TimeTable.init: first class non-NW-pupil has no instrument assigned!")
                
                // check if pupils with no profil set are in a first class
                assert(data.promotion.classNumber == 1,
                       "TimeTable.init: non-first class pupil has no profile assigned!")
            }
        }
    }
    
    private static func initializeClassLessonsFromLessonData() -> [Lesson] {
        var newLessons = [Lesson]()
        for data in LessonData.lessonDefinitions {
            // set multiplePromotionsBool
            var firstOfMultiplePromotions = true
            // loop over all promotions that the lessons apply
            for promotion in data.promotions {
                // loop over all appearances, they get numbered
                for versionNumber in 1...data.lessonsPerWeek {
                    // add the new lessons to the lessons-array
                    newLessons.append(Lesson(
                        promotion: promotion,
                        firstOfMultiplePromotions: firstOfMultiplePromotions,
                        subject: data.subject,
                        halfClassType: data.halfClassType,
                        teachers: data.teachers,
                        versionNumber: versionNumber,
                        onlyQuarter: data.onlyQuarter
                    ))
                }
                firstOfMultiplePromotions = false
            }
        }
        return newLessons
    }
    
    private static func initializeInstrumentalLessonsFromPupilData() -> [Lesson] {
        var newLessons = [Lesson]()
        
        func numberOfInitializedInstrumentalLessons(for promotion: Promotion, and teacher: TeacherData.id, and sex: Sex) -> Int {
            return newLessons
                .filter( { $0.promotion == promotion } )
                .filter( { $0.teachers.first! == teacher } )
                .filter( { $0.instrumentalSex! == sex } )
                .count
        }
        
        for data in PupilData.pupilDefinitions {
            // add the new lessons to the lessons-array
            for index in 0..<data.instruments.count {
                var newInstrumentalIndex = 1
                if data.sex == .m {
                    newInstrumentalIndex += 5 + numberOfInitializedInstrumentalLessons(for: data.promotion, and: data.instruments[index].teacher, and: .m)
                } else {
                    newInstrumentalIndex += numberOfInitializedInstrumentalLessons(for: data.promotion, and: data.instruments[index].teacher, and: .w)
                }
                var newFreeInstrumental: Bool = true
                if index == 0 {
                    switch data.focus {
                    case .mu, nil: newFreeInstrumental = false
                    case .bg:
                        if data.promotion.classNumber < 4 { newFreeInstrumental = false }
                    default: break
                    }
                }
                newLessons.append(Lesson(
                    lastName: data.lastName,
                    firstName: data.firstName,
                    promotion: data.promotion,
                    instrument: data.instruments[index],
                    instrumentalIndex: newInstrumentalIndex,
                    freeInstrumental: newFreeInstrumental,
                    instrumentalSex: data.sex))
            }
        }
        return newLessons
    }
    
    private static func initializeFreesFromPupilAndLessonData() -> [Lesson] {
        var newLessons = [Lesson]()
        let pupilDataWithFrees = PupilData.pupilDefinitions.filter { !$0.frees.isEmpty }
        
        for freeData in LessonData.freesDefinitions {
            // collect participating promotions
            var participatingPromotions = [Promotion]()
            for pupilData in pupilDataWithFrees {
                if !participatingPromotions.contains(pupilData.promotion),
                   pupilData.frees.contains(freeData.subject) {
                    participatingPromotions.append(pupilData.promotion)
                }
            }
            
            var firstOfMultiplePromotions = true
            for promotion in participatingPromotions {
                for versionNumber in 1...freeData.lessonsPerWeek {
                    newLessons.append(Lesson(
                        promotion: promotion,
                        firstOfMultiplePromotions: firstOfMultiplePromotions,
                        subject: freeData.subject,
                        halfClassType: .free,
                        teachers: freeData.teachers,
                        versionNumber: versionNumber,
                        onlyQuarter: nil
                    ))
                }
                firstOfMultiplePromotions = false
            }
        }
        return newLessons
        
    }
}


