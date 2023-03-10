//
//  GameTypeModel.swift
//  Memorizee
//
//  Created by Shruthi_ML on 17/10/22.
//

import Foundation

struct GameTypeModel : Identifiable {
    
    var id: Int
    var gameName: String
    var bgColorCode: String
    var fgColorCode: String
    var gameVM: GameVM
    
}
