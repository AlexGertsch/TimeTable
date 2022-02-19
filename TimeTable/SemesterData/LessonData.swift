//
//  ClassLessonData.swift
//  TimeTable
//
//  Created by Alexander Gertsch on 23.12.21.
//

import Foundation

struct LessonData {
    
    static let freesDefinitions: [(
        subject: Subject,
        teachers: [TeacherData.id],
        lessonsPerWeek: Int
    )] = [
        (.FFAstro, [.AGe], 2),
        (.FFPolit, [.LS], 2),
        (.FFSalsa, [.DDG, .SLe], 1),
        (.FFWeb, [.PS], 2)
    ]
    
    // In the lessonDefinitions-array,
    // every fullClass- or halfClassLesson has its own data-entry.
    // The entry's structure is shown at the top.
    
    static let lessonDefinitions: [(
        promotions: [Promotion],
        subject: Subject,
        halfClassType: Lesson.HalfClassType?,
        teachers: [TeacherData.id],
        lessonsPerWeek: Int,
        onlyQuarter: Lesson.Quarter?
    )] = [
        
        // MARK: - Promotion 153
        
        // fullClassLessons for promotion 153a
        ([.p153a], .D, nil, [.BJ], 4, nil),
        ([.p153a], .M, nil, [.TR], 4, nil),
        ([.p153a], .F, nil, [.MaB], 3, nil),
        ([.p153a], .E, nil, [.PA], 3, nil),
        ([.p153a], .G, nil, [.SaS], 2, nil),
        ([.p153a], .Gg, nil, [.IH], 2, nil),
        ([.p153a], .B, nil, [.MS], 2, nil),
        ([.p153a], .Ph, nil, [.TR], 2, nil),
        ([.p153a], .BG, nil, [.CDC], 2, nil),
        ([.p153a], .Mu, nil, [.KMK], 2, nil),
        ([.p153a], .PPP, nil, [.SM], 1, nil),
        ([.p153a], .PPP, nil, [.SU], 1, nil),
        //([.p153a], .KLS, nil, [.KMK], 1, nil),
        
        // fullClassLessons for promotion 153b
        ([.p153b], .D, nil, [.SD], 4, nil),
        ([.p153b], .M, nil, [.TR], 4, nil),
        ([.p153b], .F, nil, [.DDG], 3, nil),
        ([.p153b], .E, nil, [.PA], 3, nil),
        ([.p153b], .G, nil, [.LS], 2, nil),
        ([.p153b], .Gg, nil, [.IH], 2, nil),
        ([.p153b], .B, nil, [.MS], 2, nil),
        ([.p153b], .Ph, nil, [.TR], 2, nil),
        ([.p153b], .Mu, nil, [.AFi], 2, nil),
        ([.p153b], .PPP, nil, [.SM], 1, nil),
        ([.p153b], .PPP, nil, [.SU], 1, nil),
        //([.p153b], .KLS, nil, [.PA], 1, nil),
        
        // fullClassLessons for promotion 153c
        ([.p153c], .D, nil, [.AAl], 4, nil),
        ([.p153c], .M, nil, [.CP], 5, nil),
        ([.p153c], .F, nil, [.DDG], 3, nil),
        ([.p153c], .E, nil, [.JM], 3, nil),
        ([.p153c], .G, nil, [.SaS], 2, nil),
        ([.p153c], .Gg, nil, [.IH], 2, nil),
        ([.p153c], .B, nil, [.AL], 2, nil),
        ([.p153c], .Ch, nil, [.RA], 2, nil),
        ([.p153c], .Ph, nil, [.AGe], 2, nil),
        //([.p153c], .BG, nil, [.CDC], 2, nil),
        ([.p153c], .Mu, nil, [.AFi], 2, nil),
        ([.p153c], .Inf, nil, [.PS], 2, nil),
        //([.p153c], .KLS, nil, [.MG], 1, nil),
        
        // sports for promotions 153a&b
        ([.p153a], .Gy, .x, [.AV], 1, nil),
        ([.p153b], .Gy, .x, [.AV], 1, nil),
        ([.p153a, .p153b], .Gy, .y, [.AV], 1, nil),
        ([.p153a], .T, .x, [.FL], 2, nil),
        ([.p153b], .T, .x, [.FL], 2, nil),
        ([.p153a, .p153b], .T, .y, [.FL], 2, nil),
                 
        // sports for promotion 153c
        ([.p153c], .Gy, .x, [.AV], 1, nil),
        ([.p153c], .Gy, .y, [.AV], 1, nil),
        ([.p153c], .T, nil, [.MG], 2, nil),
        
        // further halfClassLessons for promotion 153
        ([.p153b], .BG, .x, [.SP], 2, nil),
        ([.p153b], .BG, .y, [.SP], 2, nil),
        ([.p153c], .BG, .x, [.CDC], 2, nil),
        ([.p153c], .BG, .y, [.CDC], 2, nil),
        
        // MARK: - Promotion 152
        
        // fullClassLessons for promotion 152a
        ([.p152a], .D, nil, [.SM], 4, nil),
        ([.p152a], .M, nil, [.CB], 4, nil),
        ([.p152a], .F, nil, [.MaB], 3, nil),
        ([.p152a], .E, nil, [.PA], 3, nil),
        ([.p152a], .G, nil, [.GW], 2, nil),
        ([.p152a], .Gg, nil, [.SH], 2, nil),
        ([.p152a], .B, nil, [.MS], 2, nil),
        ([.p152a], .Ch, nil, [.ThR], 2, nil),
        ([.p152a], .Ph, nil, [.AGe], 2, nil),
        ([.p152a], .Mu, nil, [.KMK], 2, nil),
        ([.p152a], .R, nil, [.RK], 2, nil),
        
        // fullClassLessons for promotion 152b
        ([.p152b], .D, nil, [.SM], 4, nil),
        ([.p152b], .M, nil, [.CP], 4, nil),
        ([.p152b], .F, nil, [.DDG], 3, nil),
        ([.p152b], .E, nil, [.PA], 3, nil),
        ([.p152b], .G, nil, [.SaS], 2, nil),
        ([.p152b], .Gg, nil, [.SH], 2, nil),
        ([.p152b], .B, nil, [.MS], 2, nil),
        ([.p152b], .Ch, nil, [.ThR], 2, nil),
        ([.p152b], .Ph, nil, [.AGe], 2, nil),
        ([.p152b], .Mu, nil, [.AFi], 2, nil),
        ([.p152b], .R, nil, [.RK], 2, nil),
        
        // fullClassLessons for promotion 152c
        ([.p152c], .D, nil, [.KZG], 4, nil),
        ([.p152c], .M, nil, [.CP], 6, nil),
        ([.p152c], .F, nil, [.IW], 3, nil),
        ([.p152c], .E, nil, [.PA], 3, nil),
        ([.p152c], .G, nil, [.SaS], 2, nil),
        ([.p152c], .Gg, nil, [.SH], 2, nil),
        ([.p152c], .B, nil, [.AL], 2, nil),
        ([.p152c], .Ch, nil, [.ThR], 2, nil),
        ([.p152c], .Ph, nil, [.AGe], 2, nil),
        ([.p152c], .BG, nil, [.CDC], 2, nil),
        //([.p152c], .Mu, nil, [.KMK], 2, nil),
        ([.p152c], .Inf, nil, [.PS], 2, nil),
        ([.p152c], .R, nil, [.RK], 2, nil),
        
        // sports for promotions 152a&b
        ([.p152a], .Gy, .x, [.AV], 1, nil),
        ([.p152b], .Gy, .x, [.AV], 1, nil),
        ([.p152a, .p152b], .Gy, .y, [.AV], 1, nil),
        ([.p152a], .T, .x, [.FL], 2, nil),
        ([.p152b], .T, .x, [.FL], 2, nil),
        ([.p152a, .p152b], .T, .y, [.FL], 2, nil),
        
        // sports for promotion 152c
        ([.p152c], .Gy, .x, [.AV], 1, nil),
        ([.p152c], .Gy, .y, [.AV], 1, nil),
        ([.p152c], .T, nil, [.MG], 2, nil),
        
        // further halfClassLessons for promotion 152
        ([.p152a], .BG, .basic, [.CDC], 2, nil),
        ([.p152b], .BG, .basic, [.SP], 2, nil),
        ([.p152a,.p152b], .BG, .focus, [.SP], 2, nil),
        ([.p152a], .BG, .focus1, [.SP], 2, nil),
        ([.p152b], .BG, .focus1, [.SP], 2, nil),
        ([.p152a, .p152b], .PPP, .focus, [.SM], 2, nil),
        ([.p152a, .p152b], .Mu, .focus, [.AFi], 1, nil),
        
        // MARK: - Promotion 151
        
        // fullClassLessons for promotion 151a
        ([.p151a], .D, nil, [.SD], 3, nil),
        ([.p151a], .M, nil, [.CP], 3, nil),
        ([.p151a], .F, nil, [.IW], 2, nil),
        ([.p151a], .E, nil, [.JM], 2, nil),
        ([.p151a], .G, nil, [.GW], 2, nil),
        //([.p151a], .WR, nil, [.MG], 2, nil),
        ([.p151a], .B, nil, [.MS], 2, .first),
        ([.p151a], .Ch, nil, [.ThR], 3, nil),
        ([.p151a], .Ph, nil, [.TR], 2, .second),
        ([.p151a], .R, nil, [.RK], 2, nil),
         
        // fullClassLessons for promotion 151b
        ([.p151b], .D, nil, [.SD], 3, nil),
        ([.p151b], .M, nil, [.CB], 3, nil),
        ([.p151b], .F, nil, [.MaB], 2, nil),
        ([.p151b], .E, nil, [.JM], 2, nil),
        ([.p151b], .G, nil, [.SaS], 2, nil),
        //([.p151b], .WR, nil, [.MG], 2, nil),
        ([.p151b], .B, nil, [.MS], 2, .first),
        ([.p151b], .Ch, nil, [.ThR], 3, nil),
        ([.p151b], .Ph, nil, [.TR], 2, .second),
        ([.p151b], .R, nil, [.RK], 2, nil),
         
        // fullClassLessons for promotion 151c
        ([.p151c], .D, nil, [.BJ], 3, nil),
        ([.p151c], .M, nil, [.TR], 4, nil),
        ([.p151c], .F, nil, [.MaB], 2, nil),
        ([.p151c], .E, nil, [.RA], 2, nil),
        ([.p151c], .G, nil, [.SaS], 2, nil),
        ([.p151c], .WR, nil, [.MG], 2, nil),
        ([.p151c], .B, nil, [.AL], 2, nil),
        ([.p151c], .BSP, nil, [.AL], 2, nil),
        ([.p151c], .ChSP, nil, [.RA], 2, nil),
        ([.p151c], .Ph, nil, [.AGe], 3, nil),
        ([.p151c], .R, nil, [.RK], 2, nil),
        ([.p151c], .IP1, nil, [.AL,.SaS,.RA], 2, .first),
        ([.p151c], .IP2, nil, [.MG,.PS], 2, .second),
        
        // language halfClassLessons for promotion 151
        ([.p151a], .F, .x, [.IW], 1, nil),
        ([.p151a], .F, .y, [.IW], 1, nil),
        ([.p151b], .F, .x, [.MaB], 1, nil),
        ([.p151b], .F, .y, [.MaB], 1, nil),
        ([.p151c], .F, .x, [.MaB], 1, nil),
        ([.p151c], .F, .y, [.MaB], 1, nil),
        ([.p151a], .E, .x, [.JM], 1, nil),
        ([.p151a], .E, .y, [.JM], 1, nil),
        ([.p151b], .E, .x, [.JM], 1, nil),
        ([.p151b], .E, .y, [.JM], 1, nil),
        ([.p151c], .E, .x, [.RA], 1, nil),
        ([.p151c], .E, .y, [.RA], 1, nil),
        
        // sports for promotions 151a&b
        ([.p151a], .Gy, .x, [.SLe], 1, nil),
        ([.p151b], .Gy, .x, [.SLe], 1, nil),
        ([.p151a, .p151b], .Gy, .y, [.SLe], 1, nil),
        ([.p151a], .T, .x, [.MG], 2, nil),
        ([.p151b], .T, .x, [.FL], 2, nil),
        ([.p151a, .p151b], .T, .y, [.MG], 2, nil),
        
        // sports for promotion 151c
        ([.p151c], .Gy, .x, [.AV], 1, nil),
        ([.p151c], .Gy, .y, [.AV], 1, nil),
        ([.p151c], .T, nil, [.FL], 2, nil),
        
        // further halfClassLessons for promotion 151
        ([.p151a], .BG, .focus2, [.SP], 2, nil),
        ([.p151b], .BG, .focus2, [.SP], 2, nil),
        ([.p151a], .BG, .focus1, [.CDC], 2, nil),
        ([.p151b], .BG, .focus1, [.CDC], 2, nil),
        ([.p151a, .p151b], .BG, .basic, [.SP], 2, nil),
        ([.p151a, .p151b], .Mu, .focus, [.KMK], 3, nil),
        ([.p151a, .p151b], .Mu, .basic, [.KMK], 2, nil),
        ([.p151a, .p151b], .PPP, .focus, [.SU,.SM], 4, nil),
        ([.p151a], .B, .x, [.MS], 2, .second),
        ([.p151a], .B, .y, [.MS], 2, .second),
        ([.p151b], .B, .x, [.MS], 2, .second),
        ([.p151b], .B, .y, [.MS], 2, .second),
        ([.p151a], .Ph, .x, [.TR], 2, .first),
        ([.p151a], .Ph, .y, [.TR], 2, .first),
        ([.p151b], .Ph, .x, [.TR], 2, .first),
        ([.p151b], .Ph, .y, [.TR], 2, .first),
        
        // MARK: - Promotion 150
        
        // fullClassLessons for promotion 150a
        ([.p150a], .D, nil, [.SD], 4, nil),
        ([.p150a], .M, nil, [.CB], 4, nil),
        ([.p150a], .F, nil, [.IW], 2, nil),
        ([.p150a], .E, nil, [.JM], 2, nil),
        ([.p150a], .G, nil, [.GW], 2, nil),
        ([.p150a], .Gg, nil, [.SH], 2, nil),
        
        // fullClassLessons for promotion 150b
        ([.p150b], .D, nil, [.SD], 4, nil),
        ([.p150b], .M, nil, [.CB], 4, nil),
        ([.p150b], .F, nil, [.IW], 2, nil),
        ([.p150b], .E, nil, [.PA], 2, nil),
        ([.p150b], .G, nil, [.GW], 2, nil),
        ([.p150b], .Gg, nil, [.SH], 2, nil),
        
        // fullClassLessons for promotion 150c
        ([.p150c], .D, nil, [.KZG], 4, nil),
        ([.p150c], .M, nil, [.AGe], 4, nil),
        ([.p150c], .F, nil, [.MaB], 2, nil),
        ([.p150c], .E, nil, [.AK], 2, nil),
        ([.p150c], .BSP, nil, [.AL], 2, nil),
        ([.p150c], .ChSP, nil, [.RA], 2, nil),
        ([.p150c], .G, nil, [.LS], 2, nil),
        ([.p150c], .Gg, nil, [.SH], 2, nil),
        ([.p150c], .IP1, nil, [.RA,.MG], 2, nil),
        //([.p150c], .IP, nil, [.SH,.AL], 2, nil),

        // language halfClassLessons for promotion 150
        ([.p150a], .F, .x, [.IW], 1, nil),
        ([.p150a], .F, .y, [.IW], 1, nil),
        ([.p150b], .F, .x, [.IW], 1, nil),
        ([.p150b], .F, .y, [.IW], 1, nil),
        ([.p150c], .F, .x, [.MaB], 1, nil),
        ([.p150c], .F, .y, [.MaB], 1, nil),
        ([.p150a], .E, .x, [.JM], 1, nil),
        ([.p150a], .E, .y, [.JM], 1, nil),
        ([.p150b], .E, .x, [.PA], 1, nil),
        ([.p150b], .E, .y, [.PA], 1, nil),
        ([.p150c], .E, .x, [.AK], 1, nil),
        ([.p150c], .E, .y, [.AK], 1, nil),
        
        // sports for promotions 150a&b
        ([.p150a], .Gy, .x, [.AV], 1, nil),
        ([.p150a], .T, .x, [.MG], 2, nil),
        ([.p150b], .Gy, .y, [.AV], 1, nil),
        ([.p150b], .T, .y, [.FL], 2, nil),
        ([.p150a, .p150b], .Gy, .z, [.AV], 1, nil),
        ([.p150a, .p150b], .T, .z, [.FL], 2, nil),
        
        // sports for promotions 150c
        ([.p150c], .Gy, .x, [.SLe], 1, nil),
        ([.p150c], .Gy, .y, [.SLe], 1, nil),
        ([.p150c], .T, nil, [.MG], 2, nil),
        
        // further halfClassLessons for promotion 150
        ([.p150a,.p150b], .BG, .focus, [.SP], 2, nil),
        ([.p150a], .BG, .focus1, [.SP], 2, nil),
        ([.p150b], .BG, .focus1, [.SP], 2, nil),
        ([.p150a, .p150b], .Mu, .focus, [.AFi], 3, nil),
        ([.p150a, .p150b], .PPP, .focus, [.SU,.SM], 4, nil),
        
        // Block mit den Ergänzungsfächern
        ([.p150a, .p150b, .p150c], .EFBS, .ef, [.MS, .MG], 4, nil),
        ([.p150a, .p150b, .p150c], .EFInt, .ef, [.SH, .SaS], 4, nil),
        ([.p150a, .p150b, .p150c], .EFR, .ef, [.RK], 4, nil),
        ([.p150b, .p150c], .EFQM, .ef, [.AGe], 4, nil),
        
        // MARK: - special lessons for multiple classes
        
        //([.p152a, .p152b, .p152c], .Chor, [.AG, .KMK, .SiS], 2, nil),
        //([.p150a, .p150b, .p151a, .p151b], .Chor, [.AG, .KMK, .SiS], 2, .MUS, nil),
        //([.p150a, .p150b, .p150c, .p151a], .FChor, [.AG, .KMK, .SiS], 2, .FF, nil),
        //([.p150a, .p150b, .p150c], .MA, [.none], 4, nil),
           
        // MUSIC-WORKSHOPS
        //([.p150a, .p150b, .p151a, .p151b, .p152a, .p152b], .Mu, [.AG,.AFi,.IA,.VM,.RM,.AFu], 2, .MuWS)]

        // first class choir
        ([.p153a, .p153b, .p153c], .Chor, nil, [.AFi,.KMK], 1, nil)
    ]
}
