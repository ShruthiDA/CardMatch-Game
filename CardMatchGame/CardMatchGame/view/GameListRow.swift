//
//  GameListRow.swift
//  Memorizee
//
//  Created by Shruthi_ML on 18/10/22.
//

import SwiftUI

struct GameListRow: View {
    
    var gameTypeModel : GameTypeModel
    @State var showLogo = false
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text(gameTypeModel.gameName).font(.system(size: 26)).padding(.vertical, 5).foregroundColor(Color(hex: gameTypeModel.fgColorCode))
            
            HStack {
                Image(gameTypeModel.gameVM.iconArray[0])
                  .resizable()
                  .frame(width: 50, height: 50)
                  .aspectRatio(contentMode: .fill)
                Image(gameTypeModel.gameVM.iconArray[1])
                  .resizable()
                  .frame(width: 50, height: 50)
                  .aspectRatio(contentMode: .fill)
                Image(gameTypeModel.gameVM.iconArray[2])
                  .resizable()
                  .frame(width: 50, height: 50)
                  .aspectRatio(contentMode: .fill)
                Image(gameTypeModel.gameVM.iconArray[3])
                  .resizable()
                  .frame(width: 50, height: 50)
                  .aspectRatio(contentMode: .fill)
                Image(gameTypeModel.gameVM.iconArray[4])
                  .resizable()
                  .frame(width: 50, height: 50)
                  .aspectRatio(contentMode: .fill)
                Spacer()
                Image("right-arrow")
                  .resizable()
                  .frame(width: 25, height: 20)
                  .aspectRatio(contentMode: .fit).foregroundColor(Color(hex: gameTypeModel.fgColorCode))
            
            }
            
            //Text(gameTypeModel.iconsArray.joined(separator: "  ")).font(.system(size: 32)).padding(.bottom, 10)
            
        }.padding(20)
            .background(Color(hex: gameTypeModel.bgColorCode)).cornerRadius(15)
            .transition(.move(edge: .leading))
        
    }
}

struct GameListRow_Previews: PreviewProvider {
    static var previews: some View {
        GameListRow(gameTypeModel: GameTypeModel(id: 1, gameName: "Game Name", bgColorCode: "8DA47E", fgColorCode: "8DA47E", gameVM: GameVM(emojiArray: ["icon list"], cardsColor: "8DA47E", gameName: "Game Name")))
    }
}

