//
//  GameVM.swift
//  Memorizee
//
//  Created by Shruthi_ML on 13/10/22.
//

import Foundation

class GameVM: ObservableObject {
    
    @Published var showSuccessAlert : Bool = false
    
    var inputLevel: GameLevel = .EASY
    var iconArray: [String] = []
    var cardsColor: String = ""
    var gameName: String = ""
    
    @Published
    var matchGame : GameModel<String> = GameModel<String>(noOfCards: 0)
    
    
    init(emojiArray: [String],cardsColor: String, gameName: String){
        //print("....init. ")
        self.iconArray = emojiArray.shuffled()
        self.cardsColor = cardsColor
        self.gameName = gameName
        //initially number of cards is 6 only
    }
    
    func createView(){
       // print("....createView calledddd. ")
        self.matchGame =  GameModel<String>(noOfCards: 6,  cardContent: { iconIndex in iconArray[iconIndex]})
    }
    
    func updateMatchGame(level: GameLevel) {
        //print("updateMatchGame..... ")
        var cardNo = 0
        inputLevel = level
        if(level == GameLevel.EASY){
            cardNo = 6
        } else if(level == GameLevel.MEDIUM){
            cardNo = 10
        } else if(level == GameLevel.HARD){
            cardNo = 15
        }
        self.matchGame =  GameModel<String>(noOfCards: cardNo,  cardContent: { iconIndex in iconArray[iconIndex]})
        
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
    
    func chooseCard(card: GameModel<String>.GameCard){
        matchGame.chooseCard(selectedGameCard: card)
    }
    
    enum GameLevel {
        case EASY
        case MEDIUM
        case HARD
    }
    
}

