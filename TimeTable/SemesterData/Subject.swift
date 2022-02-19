//
//  Subject.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 21.12.21.
//

import Foundation

enum Subject: String {
    // class-subjects
    // Hauptsprachfächer
    case D        // Deutsch
    case F        // Französisch
    case E        // Englisch
    // MINT-Fächer
    case M        // Mathematik
    case Inf      // Informatik
    case B        // Biologie
    case BSP      // Biologie Schwerpunkt
    case BC       // Biologie + Chemie
    case Ch       // Chemie
    case ChSP     // Chemie Schwerpunkt
    case Ph       // Physik
    case IP1      // Interdisziplinäre Projekte 1
    case IP2      // Interdisziplinäre Projekte 2
    // Geistes- & Sozialwissenschaften
    case G        // Geschichte
    case Gg       // Geografie
    case WR       // Einführung Wirtschaft & Recht
    case PPP      // Philosophie, Psychologie & Pädagogik
    case R        // Religion
    // Musische Fächer (egal ob GF oder SP)
    case BG       // Bildnerisches Gestalten
    case Mu       // Musik
    case Chor     // Chor
    case ZChor    // Zusatzchor
    // Sportunterricht
    case T        // Turnen
    case Gy       // Gymnastik
    // 1. Klass-Spezialfächer
    case Kl       // Klassenlehrerstunde
    // 4. Klass-Spezialfächer
    case EFBS     // Ergänzungsfach Biologie und Sport
    case EFInt    // Ergänzungsfach Integrationsfach
    case EFR      // Ergänzungsfach Religion
    case EFQM     // Ergänzungsfach Quantenmechanik
    case MA       // Maturitätsarbeit
    case Th       // Theater
    
    // frees
    case FFCh     // Freifach Chor
    case FFAstro    // Freifach Astrophysik
    case FFEsp      // Freifach Spanisch
    case FFIt       // Freifach Italienisch
    case FFPhilo    // Freifach Philosophie
    case FFPolit    // Freifach Politik
    case FFTramp    // Freifach Trampolinspringen
    case FFSalsa    // Freifach Tanzen
    case FFWeb      // Freifach Webprogrammierung
    
    // Instruments
    case bfl      // Blockflöte
    case cl       // Klarinette
    case dr       // Drums = Schlagzeug
    case git      // Gitarre
    case harp     // Harfe
    case hrn      // Horn
    case p        // Klavier
    case qfl      // Querflöte
    case sax      // Saxophon
    case tp       // Trompete
    case vc       // Cello
    case vl       // Violine
    case voc      // Sologesang
    
    static var allInstruments: [Subject] {
        [.bfl, .cl, .dr, .git, .harp, .hrn, .p, .qfl, .sax, .tp, .vc, .vl, .voc]
    }
    
    var displayed: String {
        switch self {
        case .ChSP: return "ChSP"
        case .Chor: return "Chr"
        case .ZChor: return "ZC"
        case .Kl: return "KLS"
        case .EFBS: return "BS"
        case .EFInt: return "Int"
        case .EFR: return "R"
        case .EFQM: return "𝚽"
        case .FFAstro: return "𝚽"
        case .FFPhilo: return "Pho"
        case .FFPolit: return "Ptk"
        case .FFTramp: return "Tr"
        case .FFSalsa: return "Sa"
        case .FFWeb: return "Wb"
        
        default: return self.rawValue
        }
    }
    
    var exported: String {
        switch self {
        case .FFAstro: return "FF-Astro"
        case .FFPolit: return "FF-Polit"
        case .FFSalsa: return "FF-Salsa"
        case .FFWeb: return "FF-Web"
            
        default: return self.rawValue
        }
    }
    
    var defaultRoom: Room? {
        switch self {
        case .PPP: return Room.zi111
        case .Chor: return Room.musa
        case .ZChor: return Room.thsa
        case .EFBS: return Room.zi216
        case .EFInt: return Room.zi003
        case .EFQM: return Room.zi114
        case .Th: return Room.thsa
        case .FFSalsa: return Room.musa
        default: return nil
        }
    }
}
