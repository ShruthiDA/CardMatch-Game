//
//  GameModel.swift
//  Memorizee
//
//  Created by Shruthi_ML on 4/10/22.
//

import Foundation
import SwiftUI


//Make CardContentType extend Equatable so it can be compared
struct GameModel<CardContentType> where CardContentType: Equatable {
    
    var lastCardIndex : Int?
    var cardList : [GameCard]
    var isGameComplete: Bool = false
    
    //Function should be marked as mutating when instance variable is modified
    mutating func chooseCard(selectedGameCard: GameCard){
        
        if let chosenCardIndex = cardList.firstIndex(where: { $0.id == selectedGameCard.id}), selectedGameCard.isFaceUp != true, !selectedGameCard.isMatched {
            
            if let lastChosenCardIndex = lastCardIndex {
                if(cardList[lastChosenCardIndex].cardIcon == cardList[chosenCardIndex].cardIcon) {
                    cardList[lastChosenCardIndex].isMatched = true
                    cardList[chosenCardIndex].isMatched = true
                }
                lastCardIndex = nil
            } else {
                for index in cardList.indices{
                    cardList[index].isFaceUp = false
                }
                lastCardIndex = chosenCardIndex
            }
            cardList[chosenCardIndex].isFaceUp = true
        }
        
    }
    
    init(noOfCards: Int, cardContent : (Int) -> CardContentType){
        cardList = Array()
        for i in 0..<noOfCards {
            cardList.append(GameCard(id: (i*2), cardIcon: cardContent(i)))
            cardList.append(GameCard(id: (i*2+1), cardIcon: cardContent(i)))
        }
        cardList.shuffle()
    }
    
    init(noOfCards: Int){
        cardList = Array()
        for i in 0..<noOfCards {
            cardList.append(GameCard(id: (i*2)))
            cardList.append(GameCard(id: (i*2+1)))
        }
        cardList.shuffle()
    }
    
    //Identifiable is required to idenentify each card
    struct GameCard : Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var cardIcon: CardContentType?
    }
    
    
}
