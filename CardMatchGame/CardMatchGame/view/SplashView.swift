//
//  SplashView.swift
//  Memorizee
//
//  Created by Shruthi_ML on 1/12/22.
//

import SwiftUI

struct SplashView: View {
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                RadialGradient(gradient: Gradient(colors: [Color("rose"), Color("mauve")]), center: .center, startRadius: 100, endRadius: 470)
                
                VStack {
                    
                    LottieView(name: "star_cards", loopMode: .loop)
                        .frame(width: 300, height: 300)
                    
                    Button(action: {
                        print("Play game tapped")

                    }) {
                        NavigationLink(destination: MainView().navigationBarBackButtonHidden(true)) {
                            
                            HStack {
//                                Image(systemName: "play.circle")
//                                    .font(.title)
//                                    .foregroundColor(Color("btnEndColor"))
                                Text("CARD MATCH")
                                    .fontWeight(.bold)
                                    .font(.title2).foregroundColor(Color("btnEndColor"))
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [.white, .white]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(30)
                        }.padding(.vertical, 10)
                    }
                    
                    Button(action: {
                        print("Tic Tac Toe tapped")
                    }) {
                        NavigationLink(destination: TicTacToeView().navigationBarBackButtonHidden(true)) {
                            HStack {
//                                Image(systemName: "play.circle")
//                                    .font(.title)
//                                 .foregroundColor(Color("btnEndColor"))
                                Text("TIC TAC TOE")
                                    .fontWeight(.bold)
                                    .font(.title2).foregroundColor(Color("btnEndColor"))
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [.white, .white]),
                                                       startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(30)
                        }.padding(.vertical, 10)
                    }
                    
                    Button(action: {
                        print("Setting tapped")
                    }) {
                        NavigationLink(destination: SettingView().navigationBarBackButtonHidden(true)) {
                            HStack {
//                                Image(systemName: "gearshape.circle")
//                                    .font(.title)
//                                 .foregroundColor(Color("btnEndColor"))
                                Text("SETTINGS")
                                    .fontWeight(.bold)
                                    .font(.title2).foregroundColor(Color("btnEndColor"))
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [.white, .white]),
                                                       startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(30)
                        }.padding(.vertical, 10)
                    }
                }.padding(30)
                
            }.edgesIgnoringSafeArea(.all)
        }
    }
}


struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

