//
//  GameVM.swift
//  Memorizee
//
//  Created by Shruthi_ML on 13/10/22.
//

import Foundation

class GameVM: ObservableObject {
    
    @Published var showSuccessAlert : Bool = false
    
    //static var gameLevel = GameLevel.EASY
    
    var inputLevel: GameLevel = .EASY
    var iconArray: [String] = []
    var cardsColor: String = ""
    
    @Published
    var matchGame : GameModel<String> = GameModel<String>(noOfCards: 0)
  

    init(emojiArray: [String],cardsColor: String ){
       
        print("Game emojiArray \(emojiArray)")
        print("Game cardsColor \(cardsColor)")
        self.iconArray = emojiArray.shuffled()
        self.cardsColor = cardsColor
        updateMatchGame(level: inputLevel)
    }
    
    
    func updateMatchGame(level: GameLevel) {
        print("calling update match game   \(level)")
        var cardNo = 0
        inputLevel = level
        if(level == GameLevel.EASY){
            print("Game level is - easy   6 ")
            cardNo = 6
        } else if(level == GameLevel.MEDIUM){
            print("Game level is - easy   10 ")
            cardNo = 10
        } else if(level == GameLevel.HARD){
            print("Game level is - easy   15 ")
            cardNo = 15
        }
        self.matchGame =  GameModel<String>(noOfCards: cardNo,  cardContent: { iconIndex in iconArray[iconIndex]})
        print("calling update match game   \( self.matchGame.cardList.count)    \(inputLevel)")
       
    }
    
    func isGameFinished() -> Bool {
        for i in 0..<matchGame.cardList.count {
            if (!matchGame.cardList[i].isMatched) {
                return false
            }
        }
        //To Display popup after 1 sec of selecting last card
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showSuccessAlert = true
        }
        return true
    }
    
//    var cardsList : Array<GameModel<String>.GameCard> {
//        print("Card list size \(self.matchGame.cardList.count)")
//        return matchGame.cardList
//    }
    
    func chooseCard(card: GameModel<String>.GameCard){
        matchGame.chooseCard(selectedGameCard: card)
    }
    
    enum GameLevel {
        case EASY
        case MEDIUM
        case HARD
    }
    
}

