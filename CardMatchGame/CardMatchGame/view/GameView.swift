//
//  GameView.swift
//  Memorizee
//
//  Created by Shruthi_ML on 3/10/22.
//

import SwiftUI
import AVKit

struct GameView: View {
    
    //Add ObservedObject on VM here, so view is redrawn when there's change
    @ObservedObject
    var viewModel: GameVM
    
    @State var showingAlert: Bool = false
    @State var selectedAspectRatio: CGSize = CGSize(width: 5, height: 7)
    @State var selectedMinimumWidth : CGFloat = 100
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var tapAudioPlayer: AVAudioPlayer!
    
    @State var presentAlert = false
    
    
    var body: some View {
        
        ScrollView {

            
        VStack {
                    
            Spacer()
            ZStack {
                
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: selectedMinimumWidth))]) {
                        
                        
                        ForEach(viewModel.matchGame.cardList){ cardItem in
                           
                            MatchingCardView(cardColor: viewModel.cardsColor, card: cardItem)
                                .onTapGesture {
                                    print("count \(viewModel.matchGame.cardList.count)")
                                    if (!cardItem.isMatched){
                                        viewModel.chooseCard(card: cardItem)
                                        let isdone = viewModel.isGameFinished()
                                        print("is game finished \(isdone)")
                                        print("is game finished \(viewModel.matchGame.cardList.count)")
                                        
                                    }
                                }.aspectRatio(selectedAspectRatio, contentMode:.fit)
                        }
                    }.padding(20)
                
                
                if viewModel.showSuccessAlert {

                    CustomAlert(presentAlert: $viewModel.showSuccessAlert, alertType: .success, isShowVerticalButtons: true, leftButtonAction: {
                        print("Play again......1")
                        viewModel.showSuccessAlert = false
                        viewModel.updateMatchGame(level: viewModel.inputLevel)
                    }, rightButtonAction: {
                        print("right button......2")
                        viewModel.showSuccessAlert = false
                        self.mode.wrappedValue.dismiss()
                        viewModel.updateMatchGame(level: .EASY)
                    })
                    
                    
                }
                
            }
            Spacer()
            
        
            }
            

        }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
               // self.viewModel.updateMatchGame(level: .EASY)
            }){
                Image(systemName: "chevron.left")
            }).navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Memory Match").font(.title)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NewGameButton
                }
            }.foregroundColor(Color(hex: "#575859"))
        
        
    }
    
    
    var NewGameButton : some View {
        
        Button(action: {
            if(!viewModel.showSuccessAlert){
                showingAlert = true
            }
        }){
            Text("Restart").underline()
        }.alert("Game Level", isPresented: $showingAlert) {
                Button("Easy") {
                    print("easy selelcted")
                    selectedAspectRatio = CGSize(width: 5, height: 7)
                    selectedMinimumWidth = 100
                    //viewModel.inputLevel = .EASY
                    viewModel.updateMatchGame(level: .EASY)
                }
                Button("Medium") {
                    print("medium selelcted")
                    selectedAspectRatio = CGSize(width: 5, height: 7)
                    selectedMinimumWidth = 75
                    //viewModel.inputLevel = .MEDIUM
                    viewModel.updateMatchGame(level: .MEDIUM)
                }
                Button("Hard") {
                    print("no tap hard selelcted")
                    selectedAspectRatio = CGSize(width: 5, height: 7)
                    selectedMinimumWidth = 60
                    //viewModel.inputLevel = .HARD
                    viewModel.updateMatchGame(level: .HARD)
                }
            }
    }

}

struct MatchingCardView : View {
    
    var cardColor: String
    var card: GameModel<String>.GameCard
    @State var attempts: Int = 0
    @State var tapAudioPlayer: AVAudioPlayer!
    @State var audioPlayer: AVAudioPlayer!
    @AppStorage("isSoundOn") private var isSoundEnabled = true
    
    
    var animation: Animation {
        Animation.easeOut
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                let _ = print("Card is - \(card)")
                let shape = RoundedRectangle(cornerRadius: 10)
                
                Text(card.cardIcon ?? "").font(.system(size: min(geometry.size.width, geometry.size.height)*0.8))  .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(animation)
                if (card.isMatched ) {
                    let _ = print("Card matcheddddd")
                    let b = self.audioPlayer.play()
                }
                    
                if (card.isFaceUp || card.isMatched) {
                    if (!card.isMatched ){
                        let _ = print("Tap")
                        let b = self.tapAudioPlayer.play()
                    }
                    shape.strokeBorder(lineWidth: 3).foregroundColor(Color(hex: cardColor))
                } else {
                    shape.foregroundColor(Color(hex: cardColor))
                }
            }.padding(2).animation(animation)
        }.onAppear {
            let matchedSound = Bundle.main.path(forResource: "success", ofType: "mp3")
            let tapSound = Bundle.main.path(forResource: "click-sound", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: matchedSound!))
            self.tapAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: tapSound!))
            
        }
        
    }
    
   
}


struct GameView_Previews: PreviewProvider {

    static var previews: some View {
        let gm = GameVM(emojiArray: ["🇦🇫", "🇦🇽", "🇦🇱", "🇩🇿", "🇦🇸", "🇦🇩", "🇦🇴", "🇦🇮", "🇦🇶", "🇦🇬", "🇦🇷", "🇦🇲", "🇦🇺","🇦🇼", "🇦🇹", "🇦🇿", "🇧🇸", "🇧🇩", "🇧🇭"] , cardsColor:"CAE7E3" )
        GameView(viewModel: gm)
        GameView(viewModel: gm)
    }

}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
