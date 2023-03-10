//
//  SquareModel.swift
//  CardMatchGame
//
//  Created by Shruthi_ML on 20/1/23.
//

import Foundation

class SquareModel : ObservableObject {
    
    @Published var squareStatus: SquareStatus
    
    init(squareStatus: SquareStatus) {
        self.squareStatus = squareStatus
    }
}
