//
//  MainView.swift
//  Memorizee
//
//  Created by Shruthi_ML on 17/10/22.
//

import SwiftUI

struct MainView: View {
    
    
    @State var animationDelay = 0.5
    @State var gameViewPresentedState = false
    
    @ObservedObject
    var viewModel: MainVM = MainVM()
    
    //To handle back
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    
    init() {
        
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(.gray)]
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(.gray)]
        
        UITableView.appearance().allowsSelection = false
        UITableViewCell.appearance().selectionStyle = .none
        
        
        UITableView.appearance().tableHeaderView = .init(frame: .init(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
    }
    
    
    var body: some View {
        
        
     //   NavigationView {
            
            VStack {
                
                List(viewModel.gameTypeModelList) {
                    game in
                   // var l = print ("Game    \(game.gameName)")
                    GameListRow(gameTypeModel: game)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                        .overlay(
                            NavigationLink(destination:
                                            //GameView(viewModel: GameVM(emojiArray: game.iconsArray, cardsColor:game.bgColorCode)), label: {
                                           GameView(viewModel: game.gameVM), label: {
                               
                            }).opacity(0.0)
                        ).listRowBackground(Color.clear)
                    
                }.listStyle(.plain)
                
            }.navigationTitle("Select Game").navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action : {
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
                            Text("Choose Game").font(.title)
                        }
                    }
                }.foregroundColor(Color("titleTxtColor"))
        .onAppear(perform: viewModel.createListObjects)
     //   .accentColor(Color(hex: "#575859")).onAppear(perform: viewModel.createListObjects)
        
    }
    
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

