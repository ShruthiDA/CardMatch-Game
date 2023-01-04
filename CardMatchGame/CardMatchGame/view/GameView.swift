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
    @State var showingLevelAlert: Bool = false
    
    @State var selectedAspectRatio: CGSize = CGSize(width: 5, height: 7)
    @State var selectedMinimumWidth : CGFloat = 100
    
    @State var tapAudioPlayer: AVAudioPlayer!
    @State var audioPlayer: AVAudioPlayer!
    
    @State var presentAlert = false
    
    @AppStorage("isSoundOn") private var isSoundEnabled = true
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ScrollView (.vertical){
                
                
                VStack {
                    
                    Spacer()
                    ZStack {
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: selectedMinimumWidth))]) {
                            
                            
                            ForEach(viewModel.matchGame.cardList){ cardItem in
                                
                                MatchingCardView(cardColor: viewModel.cardsColor, card: cardItem)
                                    .onTapGesture {
                                        if (!cardItem.isMatched){
                                            if(isSoundEnabled){
                                                tapAudioPlayer.play()
                                            }
                                            viewModel.chooseCard(card: cardItem)
                                            let isdone = viewModel.isGameFinished()
                                            
                                        }
                                    }.aspectRatio(selectedAspectRatio, contentMode:.fit)
                            }
                        }.padding(20)
                        
                        
                        if viewModel.showSuccessAlert {
                            
                            CustomAlert(presentAlert: $viewModel.showSuccessAlert, alertType: .success, isShowVerticalButtons: true, leftButtonAction: {
                                viewModel.showSuccessAlert = false
                                viewModel.updateMatchGame(level: viewModel.inputLevel)
                            }, rightButtonAction: {
                                viewModel.showSuccessAlert = false
                                self.mode.wrappedValue.dismiss()
                                viewModel.updateMatchGame(level: .EASY)
                            })
                            
                        }
                        
                        if showingLevelAlert {
                            GameLevelAlert
                        }
                        
                    }
                    Spacer()
                }
                .frame(width: geometry.size.width)      // Make the scroll view full-width
                .frame(minHeight: geometry.size.height) // Set the content’s min height to the parent
                
            }.navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action : {
                    self.mode.wrappedValue.dismiss()
                    self.viewModel.updateMatchGame(level: .EASY)
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
                }.foregroundColor(Color(hex: "#575859")).onAppear{
                    let matchedSound = Bundle.main.path(forResource: "success", ofType: "mp3")
                    let tapSound = Bundle.main.path(forResource: "click-sound", ofType: "mp3")
                    audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: matchedSound!))
                    tapAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: tapSound!))
                }
        }
        
        
    }
    
    
    var NewGameButton : some View {
        
        Button(action: {
            if(!showingLevelAlert){
                showingLevelAlert = true
            }
        }){
            Text("Restart").underline()
        }
    }
    
    
    var GameLevelAlert : some View {
        
        ZStack {
            
            // faded background
            Color.black.opacity(0.75)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                
                Text("Select Game level").padding(.bottom, 30).font(.title2).foregroundColor(.black)
                Button("Easy") {
                    print("easy selelcted")
                    selectedAspectRatio = CGSize(width: 5, height: 7)
                    selectedMinimumWidth = 100
                    viewModel.updateMatchGame(level: .EASY)
                    showingLevelAlert = false
                }
                Divider()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0.5)
                    .padding(.all, 0)
                Button("Medium") {
                    print("medium selelcted")
                    selectedAspectRatio = CGSize(width: 5, height: 7)
                    selectedMinimumWidth = 75
                    viewModel.updateMatchGame(level: .MEDIUM)
                    showingLevelAlert = false
                }
                Divider()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0.5)
                    .padding(.all, 0)
                Button("Hard") {
                    print("hard selelcted")
                    selectedAspectRatio = CGSize(width: 5, height: 7)
                    selectedMinimumWidth = 60
                    viewModel.updateMatchGame(level: .HARD)
                    showingLevelAlert = false
                }
                
            }  .frame(width: 300, height: 250)
                .background(
                    Color.white
                )
                .cornerRadius(15)
            
        }
    }
}

struct MatchingCardView : View {
    
    var cardColor: String
    var card: GameModel<String>.GameCard
    @State var attempts: Int = 0
    @State var audioPlayer: AVAudioPlayer!
    @AppStorage("isSoundOn") private var isSoundEnabled = true
    
    
    var animation: Animation {
        Animation.easeOut
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                
                let shape = RoundedRectangle(cornerRadius: 10)
                
                Text(card.cardIcon ?? "").font(.system(size: min(geometry.size.width, geometry.size.height)*0.8))  .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(animation, value: UUID())
                if (card.isFaceUp && card.isMatched &&  isSoundEnabled) {
                    let b = self.audioPlayer.play()
                }
                
                if (card.isFaceUp || card.isMatched) {
                    shape.strokeBorder(lineWidth: 3).foregroundColor(Color(hex: cardColor))
                } else {
                    shape.foregroundColor(Color(hex: cardColor))
                }
            }.padding(2).animation(animation, value: UUID())
        }.onAppear {
            let matchedSound = Bundle.main.path(forResource: "success", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: matchedSound!))
        }
        
    }
    
    
}


struct GameView_Previews: PreviewProvider {
    
    static var previews: some View {
        let gm = GameVM(emojiArray: ["🇦🇫", "🇦🇽", "🇦🇱", "🇩🇿", "🇦🇸", "🇦🇩", "🇦🇴", "🇦🇮", "🇦🇶", "🇦🇬", "🇦🇷", "🇦🇲", "🇦🇺","🇦🇼", "🇦🇹", "🇦🇿", "🇧🇸", "🇧🇩", "🇧🇭"] , cardsColor:"CAE7E3" )
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
