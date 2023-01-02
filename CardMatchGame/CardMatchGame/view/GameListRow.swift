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
            
            HStack {
                Text(gameTypeModel.gameName).font(.system(size: 26)).padding(.vertical, 5).foregroundColor(Color(hex: gameTypeModel.fgColorCode))
                Spacer()
                Image(systemName: "chevron.right")
                    .symbolRenderingMode(.hierarchical)
                    .font(.system(size: 20)).foregroundColor(Color(hex: gameTypeModel.fgColorCode))
            }
            Text(gameTypeModel.iconsArray.joined(separator: "  ")).font(.system(size: 32)).padding(.bottom, 10)
            
        }.padding(20)
            .background(Color(hex: gameTypeModel.bgColorCode)).cornerRadius(15)
            .transition(.move(edge: .leading))
        
    }
}

struct GameListRow_Previews: PreviewProvider {
    static var previews: some View {
        GameListRow(gameTypeModel: GameTypeModel(id: 1, gameName: "Game Name", iconsArray: ["icon list"], bgColorCode: "8DA47E", fgColorCode: "8DA47E"))
    }
}

