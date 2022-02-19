//
//  Slot.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 21.12.21.
//

import Foundation

enum Slot: Identifiable, Codable {
    var id: Slot { return self }
    
    case morning1
    case morning2
    case morning3
    case morning4
    case morning5
    case noon1
    case noon2
    case afternoon1
    case afternoon2
    case afternoon3
    case afternoon4
    case fridayAfternoon1
    case fridayAfternoon2
    case fridayAfternoon3
    case afterWeekClose1
    case afterWeekClose2
    
    static var normalDaySlots: [Slot] = earlyMorningSlots + lateMorningSlots +
        noonSlots + earlyAfternoonSlots + lateAfternoonSlots
    static var fridaySlots: [Slot] = earlyMorningSlots + lateMorningSlots +
        firstFridayAfternoonSlot + otherFridayAfternoonSlots + afterWeekCloseSlots
    static var earlyMorningSlots: [Slot] = [.morning1, .morning2, .morning3]
    static var lateMorningSlots: [Slot] = [.morning4, .morning5]
    static var noonSlots: [Slot] = [.noon1, .noon2]
    static var earlyAfternoonSlots: [Slot] = [.afternoon1, .afternoon2]
    static var lateAfternoonSlots: [Slot] = [.afternoon3, .afternoon4]
    static var firstFridayAfternoonSlot: [Slot] = [.fridayAfternoon1]
    static var otherFridayAfternoonSlots: [Slot] = [.fridayAfternoon2, .fridayAfternoon3]
    static var afterWeekCloseSlots: [Slot] = [.afterWeekClose1, .afterWeekClose2]
    
    var start: String {
        switch self {
        case .morning1: return "07:50"
        case .morning2: return "08:40"
        case .morning3: return "09:30"
        case .morning4: return "10:45"
        case .morning5: return "11:35"
        case .noon1 : return "12:25"
        case .noon2 : return "13:15"
        case .afternoon1 : return "14:05"
        case .afternoon2 : return "14:55"
        case .afternoon3 : return "15:55"
        case .afternoon4 : return "16:45"
        case .fridayAfternoon1 : return "12:40"
        case .fridayAfternoon2 : return "13:30"
        case .fridayAfternoon3 : return "14:20"
        case .afterWeekClose1 : return "15:55"
        case .afterWeekClose2 : return "16:45"
        }
    }
    
    var end: String {
        switch self {
        case .morning1: return "08:35"
        case .morning2: return "09:25"
        case .morning3: return "10:15"
        case .morning4: return "11:30"
        case .morning5: return "12:20"
        case .noon1 : return "13:10"
        case .noon2 : return "14:00"
        case .afternoon1 : return "14:50"
        case .afternoon2 : return "15:40"
        case .afternoon3 : return "16:40"
        case .afternoon4 : return "17:30"
        case .fridayAfternoon1 : return "13:25"
        case .fridayAfternoon2 : return "14:15"
        case .fridayAfternoon3 : return "15:05"
        case .afterWeekClose1 : return "16:40"
        case .afterWeekClose2 : return "17:30"
        }
    }
    
    var startExportString: String {
        switch self {
        case .morning1: return "750"
        case .morning2: return "840"
        case .morning3: return "930"
        case .morning4: return "1045"
        case .morning5: return "1135"
        case .noon1 : return "1225"
        case .noon2 : return "1315"
        case .afternoon1 : return "1405"
        case .afternoon2 : return "1455"
        case .afternoon3 : return "1555"
        case .afternoon4 : return "1645"
        case .fridayAfternoon1 : return "1240"
        case .fridayAfternoon2 : return "1330"
        case .fridayAfternoon3 : return "1420"
        case .afterWeekClose1 : return "1555"
        case .afterWeekClose2 : return "1645"
        }
    }
    
    var lateStartExportString: String {
        switch self {
        case .morning1: return "813"
        case .morning2: return "903"
        case .morning3: return "953"
        case .morning4: return "1108"
        case .morning5: return "1158"
        case .noon1 : return "1248"
        case .noon2 : return "1338"
        case .afternoon1 : return "1428"
        case .afternoon2 : return "1518"
        case .afternoon3 : return "1618"
        case .afternoon4 : return "1708"
        case .fridayAfternoon1 : return "1303"
        case .fridayAfternoon2 : return "1353"
        case .fridayAfternoon3 : return "1443"
        case .afterWeekClose1 : return "1618"
        case .afterWeekClose2 : return "1708"
        }
    }
    
}
