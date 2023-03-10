//
//  TicTacToeModel.swift
//  CardMatchGame
//
//  Created by Shruthi_ML on 20/1/23.
//

import Foundation

class TicTacToeModel : ObservableObject{
    
    @Published var squares = [SquareModel]()
    
    init() {
        for _ in 0...8{
            squares.append(SquareModel(squareStatus: .empty))
        }
        print("created model \(squares.count)")
    }
    
    func resetGame(){
        squares.removeAll()
        for _ in 0...8 {
            squares.append(SquareModel(squareStatus: .empty))
        }
    }

    private var thereIsAWinner: SquareStatus {
        get {
            if let check = checkIndexCount(indexList: [0, 1, 2]){
                return check
            } else  if let check = checkIndexCount(indexList: [3,4,5]){
                return check
            } else if let check = checkIndexCount(indexList: [6,7,8]){
                return check
            } else if let check = checkIndexCount(indexList: [0,3,6]){
                return check
            } else if let check = checkIndexCount(indexList: [1,4,7]){
                return check
            } else if let check = checkIndexCount(indexList: [2,5,8]){
                return check
            } else if let check = checkIndexCount(indexList: [0,4,8]){
                return check
            } else if let check = checkIndexCount(indexList: [2,4,6]){
                return check
            } else {
                return .empty
            }
        }

    }

    func checkIndexCount(indexList: [Int]) -> SquareStatus? {
        var homeCount = 0
        var visitorCount = 0

        for index in indexList{
            var square = squares[index]
            if(square.squareStatus == .visitor){
                visitorCount+=1
            } else if(square.squareStatus == .home){
                homeCount+=1
            }
        }

        if(homeCount == 3){
            return .home
        }else if(visitorCount == 3){
            return .visitor
        }else{
            return nil
        }

    }

    var gameOver : (SquareStatus, Bool){
        get {
            if(thereIsAWinner != .empty){
                return (thereIsAWinner, true)
            } else {
                for i in 0...8{
                    if(squares[i].squareStatus == .empty){
                        return (.empty, false)
                    }
                }
                return (.empty, true)
            }
        }
    }

    func moveAI(){
        var index = Int.random(in: 0...8)
        while (makeAMove(index: index, player: .visitor) == false &&
                gameOver.1 == false)
        {
            index = Int.random(in: 0...8)
        }
       
    }
    
    func makeAMove(index: Int, player: SquareStatus)-> Bool{
        
        if(squares[index].squareStatus == .empty){
            squares[index].squareStatus = player
            if(player == .home){
                moveAI()
            }
            return true
        }
        return false
    }
}
