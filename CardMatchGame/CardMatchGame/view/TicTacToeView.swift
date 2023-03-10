//
//  TicTacToe.swift
//  CardMatchGame
//
//  Created by Shruthi_ML on 20/1/23.
//

import SwiftUI

struct TicTacToeView: View {
    
    @ObservedObject var vm = TicTacToeVM()
    
    @State var gameOver : Bool = false
    
    func buttonAction(_ index: Int){
        _ = self.vm.ticTacToeGame.makeAMove(index: index, player: .home)
        self.gameOver = self.vm.ticTacToeGame.gameOver.1
    }
    
    //To handle back
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        
        ZStack {
            Image("pinkBgs").resizable()
                .scaledToFill()
            VStack {
               
                ForEach(0 ..< (vm.ticTacToeGame.squares.count/3), content: {
                    row in
                    
                    HStack {
                        ForEach(0 ..< 3, content: {
                            column in
                            // Color.gray.frame(width: 60, height: 60, alignment: .center)
                            
                            let index = row * 3 + column
                            
                            SquareView(squareModel: vm.ticTacToeGame.squares[index]) {
                                self.buttonAction(index)
                            }
                            
                        })
                    }
                    
                })
            }.edgesIgnoringSafeArea(.all).navigationTitle("Tic Tac Toe").navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action : {
                    vm.ticTacToeGame.resetGame()
                    self.mode.wrappedValue.dismiss()
                }){
                    Image("back-arrow")
                      .resizable()
                      .frame(width: 25, height: 20)
                      .aspectRatio(contentMode: .fit)
                }).navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text("Tic Tac Toe").font(.title)
                        }
                    }
                }.foregroundColor(Color("titleTxtColor"))
            
        }.alert(isPresented: self.$gameOver) {
            Alert(title: Text("GAME OVER"), message: Text(self.vm.ticTacToeGame.gameOver.0 != .empty ? self.vm.ticTacToeGame.gameOver.0 != .visitor ? "Congratulation! You Won " : "You Lost, Better luck next time " :  "Match draw! No winner"), dismissButton: Alert.Button.destructive(Text("Play Again"), action: {
                self.vm.ticTacToeGame.resetGame()
            }))
        }
    }
}

struct TicTacToe_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToeView()
    }
}

enum SquareStatus{
    case home
    case empty
    case visitor
}

struct SquareView: View {
    
    @ObservedObject var squareModel: SquareModel
    var btnAction:() -> Void
    
    var body: some View {
        
        Button(action: {
            self.btnAction()
        }, label: {
            Text(squareModel.squareStatus == .home ? "X" : squareModel.squareStatus == .visitor ? "O" : "") .font(.system(size: 32, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 80, height: 80, alignment:.center)
                .background(Color("pinkColor").cornerRadius(10)).padding(5)
        })
       
    }
}
