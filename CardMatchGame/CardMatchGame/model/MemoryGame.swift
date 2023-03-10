//
//  MemoryGame.swift
//  Memorizee
//
//  Created by Shruthi_ML on 28/9/22.
//

import Foundation
import SwiftUI

struct MemoryGame<ContentType> {
    
    var cards : Array<Card>
    
    
    init(noOfCards: Int, createContent: (Int)->ContentType){
        cards = Array<Card>()
        for index in 0..<noOfCards{
            //Function is passed as argument, which takes noOfCards & return the content
            cards.append(Card(content: createContent(index)))
        }
    }
    
    struct Card {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: ContentType
    }
    
}
