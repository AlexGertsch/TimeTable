//
//  TeacherData.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 21.12.21.
//

import Foundation
//import AppKit

struct TeacherData {
    
    enum id: String, CaseIterable, Identifiable {
        var id: TeacherData.id { self }
        
        case none = ""
        case unknown = "k.A."
        case ext
        
        // teacherIDs are identical with those in "schul-netz"
        // to define a new teacher just start with this id
        // further required informations will be told by the error-warnings in this file
        case RA
        case PA
        case IA
        case AAl
        case JB
        case MaB
        case CB
        case DDG
        case SD
        case CDC
        case SdT
        case AFi
        case AFu
        case MG
        case AGe
        case AG
        case IH
        case SH
        case BJ
        case DJ
        case LeK
        case RK
        case AK
        case SLe
        case FL
        case AL
        case SM
        case VM
        case RM
        case JM
        case KMK
        case GN
        case EO
        case CP
        case SP
        case ThR
        case TR
        case SiS
        case PS
        case MS
        case SaS
        case LS
        case SSO
        case SU
        case AV
        case AW
        case GW
        case IW
        case KZG
        case HPZ
    }
    
    static var instrumentalTeachers: [TeacherData.id] {
        var instrumentalTeachers = [TeacherData.id]()
        for teacher in TeacherData.id.allCases {
            if personalData(for: teacher).instrumentalShortcut != nil {
                instrumentalTeachers.append(teacher)
            }
        }
        return instrumentalTeachers
    }
    
    static var instrumentalTeachersSortedByShortCut: [TeacherData.id] {
        instrumentalTeachers.sorted { personalData(for: $0).instrumentalShortcut! < personalData(for: $1).instrumentalShortcut! }
    }
    
    static func getImpossibilities(for teacherId: id) -> [Meeting] {
        switch teacherId {
        case .RA: return [do7,do8,do9,do10,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .PA: return [mo10,mo11,di10,di11,do10,do11,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .IA: return [mo1,mo2,mo3,mo4,mo5,mo6,mo7,mo8,mo9,mo10,mo11,di1,di2,mi1,mi2,mi3,mi4,mi5,mi6,mi7,mi8,mi9,mi10,mi11,do1,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .AAl: return [mo1,mo11,di1,di11,mi1,mi7,mi8,mi9,mi10,mi11,do1,do11,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .JB: return [mo4,mo5,mo6,mo7,mo8,mo9,mo10,mo11,di1,di2,di3,di4,di5,di6,di7,di8,mi1,mi2,mi3,mi4,mi5,mi6,mi7,mi8,mi9,mi10,mi11,do5,do6,do7,do8,do9,do10,do11,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .MaB: return [mi1,mi2,mi3,mi4,mi5,mi6,mi7,mi8,mi9,mi10,mi11]
        case .CB: return []
        case .DDG: return [di1,di2,di3,di4,di5,di6,di7,di8,di9,di10,di11,mi1,mi2,mi3,mi4,mi5,mi6,mi7,mi8,mi9,mi10,mi11]
        case .SD: return [mo1,mo11,di1,di5,di6,di7,di8,di9,di10,di11,mi5,mi6,mi7,mi8,mi9,mi10,mi11,do1,do7,do8,do9,do10,do11]
        case .CDC: return [mo1,di1,di2,di3,di4,di5,di6,di7,do1,do7,do8,do9,do10,do11,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .SdT: return [mo1,di1,di8,di9,di10,di11,mi1,mi2,mi3,mi4,mi5,mi6,mi7,mi8,mi9,mi10,mi11,do1,do2,do3,do11,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .AFi: return [mo1,di1,di2,di3,di4,di5,di6,di7,di8,di9,di10,di11,mi11]
        case .AFu: return [mo6,mo7,mo8,mo9,mo10,mo11,mi1,mi2,mi3,mi4,mi5,mi6,mi7,mi8,mi9,mi10,mi11,do1,do2,do3,do4,do5,do6,do7,do8,do9,do10,do11,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .MG: return [mo3,di1,mi1,mi2,mi3,mi4,mi5,mi6,mi7,mi8,mi9,mi10,mi11]
        case .AGe: return [di1,di2,di3,di4,di5,di6,di7,di8,di9,di10,di11]
        case .AG: return [mi1,mi2,mi3,mi4,mi5,mi6,mi7,mi8,mi9,mi10,mi11,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .IH : return [fr6,fr7,fr8,fr9,fr10]
        case .SH: return [mo1,mo2,mo3,mo4,mo5,mo6,mo7,di1,mi1,do1,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .BJ: return [di8,di9,di10,di11,mi8,mi9,mi10,mi11,do1,do2,do3,do4,do5,do6,do7,do8,do9,do10,do11,fr7,fr8,fr9,fr10]
        case .DJ: return [mo1,mo2,mo3,mo4,mo5,mo6,mo7,mo8,mo9,mo10,mo11,di8,di9,di10,di11,mi1,mi2,mi3,mi4,mi5,mi6,mi7,mi8,mi9,mi10,mi11,do1,do2,do3,do4,do5,do6,do7,do8,do9,do10,do11,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .LeK : return [mo1,di1,mi1,mi2,mi3,mi4,mi5,mi6,mi7,mi8,mi9,mi10,mi11,do1,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .RK : return [mo1,mo2,mo3,mo4,mo5,mo6,mo7,mo8,mo9,mo10,mo11,di1,di2,di3,di4,di5,di6,di7,di8,di9,di10,di11,mi5,mi6,mi7,mi8,mi9,mi10,mi11]
        case .AK : return [di7,di8,di9,di10,di11,do1,do2,do3,do4,do5,do6,do7,do8,do9,do10,do11,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .SLe : return [mo6,mo7,mo8,mo9,mo10,mo11,di1,di2,di3,di4,di5,di6,di7,di8,di9,di10,di11,mi1,mi2,mi3,mi4,mi5,mi6,mi7,mi8,mi9,mi10,mi11,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .FL : return [mo3,di7,di8,di9,di10,di11,mi7,mi8,mi9,mi10,mi11,do1,do2,do3,do4,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8]
        case .AL : return [mo1,mo2,mo3,mo4,mo5,mo6,mo7,mo8,mo9,mo10,mo11,mi7,mi8,mi9,mi10,mi11,do6,do7,do8,do9,do10,do11,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .SM : return []
        case .VM : return [mo1,mo8,mo9,mo10,mo11,di1,di8,di9,di10,di11,mi1,mi2,mi3,mi4,mi5,mi6,mi7,mi8,mi9,mi10,mi11,do1,do2,do3,do4,do8,do9,do10,do11,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .RM : return [mo1,mo2,mo3,mo4,mo5,mo6,mo7,mo8,mo9,mo10,mo11,di1,di11,mi1,mi2,mi3,mi4,mi5,mi6,mi7,mi8,mi9,mi10,mi11,do1,do2,do3,do4,do5,do6,do7,do8,do9,do10,do11,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .GN : return [mo5,mo6,mo7,mo8,mo9,mo10,mo11,di4,di5,di6,di7,di8,di9,di10,di11,mi1,mi2,mi3,mi4,mi5,mi6,mi7,mi8,mi9,mi10,mi11,do7,do8,do9,do10,do11,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .JM : return [fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .KMK : return [mo1,mi5,mi6,mi7,mi8,mi9,mi10,mi11,do9,do10,do11,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .EO : return [mo1,mo2,mo3,mo4,mo5,mo6,mo7,mo8,mo9,mo10,mo11,di8,di9,di10,di11,mi1,mi2,mi3,mi4,mi5,mi6,mi7,mi8,mi9,mi10,mi11,do1,do2,do3,do4,do5,do6,do7,do8,do9,do10,do11,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .CP : return [mo7,mo10,mo11,di10,di11,do10,do11]
        case .SP : return []
        case .ThR : return []
        case .TR : return [do4,do5,do6,do7,do8,do9,do10,do11]
        case .SiS : return [di1,di2,di3,di4,di5,di6,di7,di8,di9,di10,di11,mi1,mi2,mi3,mi4,mi5,mi6,mi7,mi8,mi9,mi10,mi11,do1,do2,do3,do4,do5,do6,do7,do8,do9,do10,do11,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .PS : return [mo1,mo2,mo3,mo4,mo5,mo6,mo7,mo8,mo9,mo10,mo11,di1,di2,di3,di4,di5,di6,di7,di8,di9,di10,di11,mi1,mi2,mi3,mi4,mi5,mi6,mi7,mi8,mi9,mi10,mi11]
        case .MS : return [mo1,fr1]
        case .SaS : return [mi1,mi2,mi3,mi4,mi5,mi6,mi7,mi8,mi9,mi10,mi11,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .LS : return [mo10,mo11,di1,di2,di3,di4,di5,di6,di7,di8,di9,di10,di11,mi9,mi10,mi11,do1,do2,do3,do4,do5,do6,do7,do8,do9,do10,do11]
        case .SSO : return [mo1,mo2,mo8,mo9,mo10,mo11,di1,di2,di3,di4,di5,di6,di7,di8,di9,di10,di11,mi1,mi2,mi3,mi4,mi5,mi6,mi7,mi8,mi9,mi10,mi11,do1,do2,do8,do9,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .SU : return [mi1,mi2,mi3,mi4,mi5,mi6,mi7,mi8,mi9,mi10,mi11,do1,do2,do3,do4,do5,do6,do7,fr1,fr2,fr3,fr3,fr4,fr5]
        case .AV : return [mo1,di1,mi1,do1,fr1,fr2,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .AW : return [mo1,mo2,mo3,mo4,mo5,mo6,mo7,mo8,mo9,mo10,mo11,di8,di9,di10,di11,mi1,mi2,mi3,mi4,mi5,mi6,mi7,mi8,mi9,mi10,mi11,do8,do9,do10,do11,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
        case .GW : return [mo1,mo2,mo3,di1,di2,di3,mi1,mi2,mi3,do1,do2,do3,fr1,fr2,fr3]
        case .IW : return [mo1,mo2,mo3,mo4,mo5,mo6,mo7,mo8,mo9,mo10,mo11,do6,do7,do8,do9,do10,do11]
        case .KZG : return [mo1,mo10,mo11,di10,di11,mi1,mi5,mi6,mi7,mi8,mi9,mi10,mi11,do1,do9,do10,do11,fr1,fr8,fr9,fr10]
        case .HPZ : return [mo1,mo2,mo3,mo9,mo10,mo11,di1,di2,di3,di4,di5,di9,di10,di11,mi1,mi2,mi3,mi4,mi5,mi6,mi7,mi8,mi9,mi10,mi11,do1,do2,do3,fr1,fr2,fr3,fr3,fr4,fr5,fr6,fr7,fr8,fr9,fr10]
            
        default: return []
        }
    }
    
    static func personalData(for teacherId: id) -> (
        lastName: String,
        firstName: String,
        color: CGColor,
        instrumentalShortcut: String?,
        defaultRoom: Room?
    ) {
        switch teacherId {
        case .none: return ("", "", CGColor(gray: 1, alpha: 1), nil, nil)
        case .unknown: return ("Angabe", "keine", CGColor(gray: 1, alpha: 1), nil, nil)
        case .ext: return ("extern", "", CGColor(gray: 1, alpha: 1), nil, nil)
            
        case .RA: return ("Adam", "Reinhold", #colorLiteral(red: 0.924633399, green: 0.5727436059, blue: 0.9922036872, alpha: 1), nil, .zi218)
        case .PA: return ("Alex", "Preethy", #colorLiteral(red: 0.9922036872, green: 0.6993842203, blue: 0.9632511462, alpha: 1), nil, .zi208)
        case .IA: return ("Alexandre", "Ingrid", #colorLiteral(red: 0.9922036872, green: 0.6993842203, blue: 0.9632511462, alpha: 1), "n", .zi305)
        case .AAl: return ("Altorfer", "Anja", #colorLiteral(red: 0.9309961632, green: 0.6375749876, blue: 0.6929178044, alpha: 1), nil, .zi105)
        case .JB: return ("Baer Wopmann", "Johanna", #colorLiteral(red: 0.9922036872, green: 0.7054368923, blue: 0.4528265151, alpha: 1), "d", .zi306)
        case .MaB: return ("Bertschi", "Mara", #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0.9241203008), nil, .zi206)
        case .CB: return ("Bünger", "Corinna", #colorLiteral(red: 0.7208389884, green: 0.5978388169, blue: 1, alpha: 1), nil, .zi107)
        case .DDG: return ("De Giorgi", "Davide", #colorLiteral(red: 0.9353976376, green: 0.7593524474, blue: 0.8504231927, alpha: 1), nil, .zi206)
        case .SD: return ("Deicke", "Sandra", #colorLiteral(red: 0.9843395173, green: 0.3084737498, blue: 0.327547776, alpha: 1), nil, .zi105)
        case .CDC: return ("Della Chiesa", "Carlo", #colorLiteral(red: 0.9788305696, green: 0.971428437, blue: 0.7569174304, alpha: 1), nil, .zi319)
        case .SdT: return ("du Toit", "Stefan", #colorLiteral(red: 0.9843395173, green: 0.3084737498, blue: 0.327547776, alpha: 1), "c", .zi320)
        case .AFi: return ("Fischer", "Andrea", #colorLiteral(red: 1, green: 0.8684717131, blue: 0.5982735604, alpha: 1), nil, .zi309)
        case .AFu: return ("Furuya", "Ai", #colorLiteral(red: 0.2924582912, green: 0.8701030186, blue: 0.556940355, alpha: 1), "e", .zi317)
        case .MG: return ("Galley", "Matthias", #colorLiteral(red: 1, green: 0.3605942587, blue: 0, alpha: 1), nil, .th)
        case .AGe: return ("Gertsch", "Alexander", #colorLiteral(red: 0.4644824352, green: 0.895712636, blue: 1, alpha: 1), nil, .zi114)
        case .AG: return ("Gohl-Alvera", "Andreas", #colorLiteral(red: 0.6003053958, green: 0.8765976657, blue: 0.9392413992, alpha: 1), "h", .zi316)
        case .IH: return ("Henzmann", "Isabelle", #colorLiteral(red: 0.5513230749, green: 1, blue: 0.5013521938, alpha: 1), nil, .zi003)
        case .SH: return ("Hesske", "Stefan", #colorLiteral(red: 0.08113359414, green: 1, blue: 0.08882690664, alpha: 1), nil, .zi003)
        case .BJ: return ("Jehle", "Barbara", #colorLiteral(red: 0.9922036872, green: 0.3790054911, blue: 0.5946785008, alpha: 1), nil, .zi105)
        case .DJ: return ("Jordi-Körte", "Daniela", #colorLiteral(red: 0.7705727649, green: 0.6482980729, blue: 0.5088472114, alpha: 1), "w", .zi313)
        case .LeK: return ("Kiepenheuer", "Lena", #colorLiteral(red: 0.2744995079, green: 0.5696986441, blue: 0.8701030186, alpha: 1), "k", .zi314)
        case .RK: return ("Klopfenstein", "Rolf", #colorLiteral(red: 0.7705727649, green: 0.6482980729, blue: 0.5088472114, alpha: 1), nil, .zi307)
        case .AK: return ("Kreis", "Annette", #colorLiteral(red: 0.9922036872, green: 0.4775210517, blue: 0.8200345842, alpha: 1), nil, .zi208)
        case .SLe: return ("Lemm", "Silvana", #colorLiteral(red: 1, green: 0.7418687004, blue: 0.4216751934, alpha: 1), nil, .gym)
        case .FL: return ("Lüchinger", "Fabian", #colorLiteral(red: 1, green: 0.5249770887, blue: 0.389231395, alpha: 1), nil, .th)
        case .AL: return ("Lüssi", "Agnes", #colorLiteral(red: 0.5242278905, green: 1, blue: 0.8518219474, alpha: 1), nil, .zi216)
        case .SM: return ("Marcec", "Stefan", #colorLiteral(red: 0.7705727649, green: 0.4004029602, blue: 0.3000155971, alpha: 1), nil, .zi111)
        case .VM: return ("Marti", "Valentin", #colorLiteral(red: 0.726203143, green: 0.5177861345, blue: 0.9392413992, alpha: 1), "s", .zi314)
        case .RM: return ("Maurer", "Regula", #colorLiteral(red: 0.5242278905, green: 1, blue: 0.8518219474, alpha: 1), "b", .zi323)
        case .JM: return ("Mitterhofer", "Jeannette", #colorLiteral(red: 0.9922036872, green: 0.6089620368, blue: 0.7948455147, alpha: 1), nil, .zi208)
        case .KMK: return ("Müller Klusman", "Kurt", #colorLiteral(red: 0.607107301, green: 0.5858067071, blue: 1, alpha: 1), "l", .zi309)
        case .GN: return ("Nemeti", "Gabor", #colorLiteral(red: 0.8211323421, green: 1, blue: 0.178559555, alpha: 1), "m", .zi303)
        case .EO: return ("Olsen", "Eveleen", #colorLiteral(red: 0.9379729952, green: 0.9788305696, blue: 0, alpha: 1), "v", .zi314)
        case .CP: return ("Perle", "Caroline", #colorLiteral(red: 0.8551319004, green: 0.7886649827, blue: 1, alpha: 1), nil, .zi112)
        case .SP: return ("Pietz", "Silvia", #colorLiteral(red: 0.938032564, green: 0.8894111666, blue: 0.02132374216, alpha: 1), nil, .zi319)
        case .ThR: return ("Rechsteiner", "Thomas", #colorLiteral(red: 0.9856959147, green: 0.8250734462, blue: 0.9922036872, alpha: 1), nil, .zi218)
        case .TR: return ("Rosskopf", "Tobias", #colorLiteral(red: 0.6821544697, green: 0.9004417995, blue: 1, alpha: 1), nil, .zi114)
        case .SiS: return ("Savoy", "Simon", #colorLiteral(red: 1, green: 0.8448276558, blue: 0, alpha: 1), "y", .zi317)
        case .PS: return ("Schaffner", "Philip", #colorLiteral(red: 0.4835546764, green: 0.6515111897, blue: 1, alpha: 1), nil, .zi003)
        case .MS: return ("Schneider", "Marc", #colorLiteral(red: 0.09225929672, green: 1, blue: 0.7251517257, alpha: 1), nil, .zi216)
        case .SaS: return ("Schönholzer", "Sandra", #colorLiteral(red: 0.8001319639, green: 1, blue: 0.4921267143, alpha: 1), nil, .zi002)
        case .LS: return ("Strub", "Lukas", #colorLiteral(red: 0.5726758457, green: 1, blue: 0.1441301499, alpha: 1), nil, .zi002)
        case .SSO: return ("Süss-Olsson", "Solveig", #colorLiteral(red: 0.8551319004, green: 0.7886649827, blue: 1, alpha: 1), "f", .zi306)
        case .SU: return ("Untersander", "Sarah", #colorLiteral(red: 0.7705727649, green: 0.5463522929, blue: 0.3004564657, alpha: 1), nil, .zi111)
        case .AV: return ("Vuckovic-Spielmann", "Andrea", #colorLiteral(red: 1, green: 0.6303792358, blue: 0, alpha: 1), nil, .gym)
        case .AW: return ("Walter", "Andreas", #colorLiteral(red: 0.9843395173, green: 0.4855130193, blue: 0.5828486288, alpha: 1), "a", .zi321)
        case .GW: return ("Weber", "Gianna Virginia", #colorLiteral(red: 0.8211323421, green: 1, blue: 0.178559555, alpha: 1), nil, .zi002)
        case .IW: return ("Weber", "Imke", #colorLiteral(red: 0.8718000947, green: 0.5660355687, blue: 0.6857077665, alpha: 1), nil, .zi206)
        case .KZG: return ("Zegar Gardeyn", "Karolina", #colorLiteral(red: 0.9843395173, green: 0.4855130193, blue: 0.5828486288, alpha: 1), nil, .zi105)
        case .HPZ: return ("Zenger", "Hanspeter", #colorLiteral(red: 0.5726758457, green: 1, blue: 0.1441301499, alpha: 1), "z", .zi313)
        }
    }
    
    // Shortcuts for all possible tuples (Day, Slot)
    static private let mo1 = Meeting(on: .monday, in: .morning1)
    static private let mo2 = Meeting(on: .monday, in: .morning2)
    static private let mo3 = Meeting(on: .monday, in: .morning3)
    static private let mo4 = Meeting(on: .monday, in: .morning4)
    static private let mo5 = Meeting(on: .monday, in: .morning5)
    static private let mo6 = Meeting(on: .monday, in: .noon1)
    static private let mo7 = Meeting(on: .monday, in: .noon2)
    static private let mo8 = Meeting(on: .monday, in: .afternoon1)
    static private let mo9 = Meeting(on: .monday, in: .afternoon2)
    static private let mo10 = Meeting(on: .monday, in: .afternoon3)
    static private let mo11 = Meeting(on: .monday, in: .afternoon4)
    
    static private let di1 = Meeting(on: .tuesday, in: .morning1)
    static private let di2 = Meeting(on: .tuesday, in: .morning2)
    static private let di3 = Meeting(on: .tuesday, in: .morning3)
    static private let di4 = Meeting(on: .tuesday, in: .morning4)
    static private let di5 = Meeting(on: .tuesday, in: .morning5)
    static private let di6 = Meeting(on: .tuesday, in: .noon1)
    static private let di7 = Meeting(on: .tuesday, in: .noon2)
    static private let di8 = Meeting(on: .tuesday, in: .afternoon1)
    static private let di9 = Meeting(on: .tuesday, in: .afternoon2)
    static private let di10 = Meeting(on: .tuesday, in: .afternoon3)
    static private let di11 = Meeting(on: .tuesday, in: .afternoon4)
    
    static private let mi1 = Meeting(on: .wednesday, in: .morning1)
    static private let mi2 = Meeting(on: .wednesday, in: .morning2)
    static private let mi3 = Meeting(on: .wednesday, in: .morning3)
    static private let mi4 = Meeting(on: .wednesday, in: .morning4)
    static private let mi5 = Meeting(on: .wednesday, in: .morning5)
    static private let mi6 = Meeting(on: .wednesday, in: .noon1)
    static private let mi7 = Meeting(on: .wednesday, in: .noon2)
    static private let mi8 = Meeting(on: .wednesday, in: .afternoon1)
    static private let mi9 = Meeting(on: .wednesday, in: .afternoon2)
    static private let mi10 = Meeting(on: .wednesday, in: .afternoon3)
    static private let mi11 = Meeting(on: .wednesday, in: .afternoon4)
    
    static private let do1 = Meeting(on: .thursday, in: .morning1)
    static private let do2 = Meeting(on: .thursday, in: .morning2)
    static private let do3 = Meeting(on: .thursday, in: .morning3)
    static private let do4 = Meeting(on: .thursday, in: .morning4)
    static private let do5 = Meeting(on: .thursday, in: .morning5)
    static private let do6 = Meeting(on: .thursday, in: .noon1)
    static private let do7 = Meeting(on: .thursday, in: .noon2)
    static private let do8 = Meeting(on: .thursday, in: .afternoon1)
    static private let do9 = Meeting(on: .thursday, in: .afternoon2)
    static private let do10 = Meeting(on: .thursday, in: .afternoon3)
    static private let do11 = Meeting(on: .thursday, in: .afternoon4)
    
    static private let fr1 = Meeting(on: .friday, in: .morning1)
    static private let fr2 = Meeting(on: .friday, in: .morning2)
    static private let fr3 = Meeting(on: .friday, in: .morning3)
    static private let fr4 = Meeting(on: .friday, in: .morning4)
    static private let fr5 = Meeting(on: .friday, in: .morning5)
    static private let fr6 = Meeting(on: .friday, in: .fridayAfternoon1)
    static private let fr7 = Meeting(on: .friday, in: .fridayAfternoon2)
    static private let fr8 = Meeting(on: .friday, in: .fridayAfternoon3)
    static private let fr9 = Meeting(on: .friday, in: .afterWeekClose1)
    static private let fr10 = Meeting(on: .friday, in: .afterWeekClose2)
}
