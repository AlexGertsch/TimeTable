//
//  Promotion.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 21.12.21.
//

import Foundation

enum Promotion: String, CaseIterable, Identifiable {
    case p153a = "153a"
    case p153b = "153b"
    case p153c = "153c"
    case p152a = "152a"
    case p152b = "152b"
    case p152c = "152c"
    case p151a = "151a"
    case p151b = "151b"
    case p151c = "151c"
    case p150a = "150a"
    case p150b = "150b"
    case p150c = "150c"
    
    // Aktuelle Erstklasspromotion
    static var firstClassProm = 153
    
    var isMaturaClass: Bool {
        promNumber == Promotion.firstClassProm - 3
    }
    
    var id: Promotion { self }
    
    // Anzahl Klassen
    static var numberOfPromotions: Int { Promotion.allCases.count }
    
    // Ermittle den Index einer bestimmten Promotion im allCases-Array
    var indexInAllCases: Int { Promotion.allCases.firstIndex(of: self)! }
    
    // Erzeuge die Promotionsnummer aus dem rawValue der Promotion
    var promNumber: Int {
        assert(self.rawValue.count == 4, "rawValue of Prom has not exactly 4 characters!")
        var stringedRawValue = self.rawValue
        stringedRawValue.removeLast()
        let withoutAbc = Int(stringedRawValue)
        assert(withoutAbc != nil, "Not all of the first 3 characters of rawValue of Prom are integers")
        assert(withoutAbc! > 140 && withoutAbc! < 180, "number in rawValue of enumeration Prom is not between 140 and 180!")
        return withoutAbc!
    }
    
    // Erzeuge die Klassennummer aus dem rawValue der Promotion
    var classNumber: Int {
        return Promotion.firstClassProm - promNumber + 1
    }
    
    // Erzeuge den Klassenbuchstaben aus dem rawValue der Promotion
    var classChar: String {
        assert(self.rawValue.count == 4, "rawValue of Prom has not exactly 4 characters!")
        var withAbc = self.rawValue
        return String(withAbc.removeLast())
    }
    
    // Erzeuge den Klassennamen aus dem rawValue der Promotion
    var displayed: String {
        return String(self.classNumber) + self.classChar
    }
    
}
