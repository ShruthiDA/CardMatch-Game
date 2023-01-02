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
        
    }

    
    var body: some View {
        
        
        NavigationView {
            
            VStack {
                
                List(viewModel.gameTypeModelList) {
                    game in
                    GameListRow(gameTypeModel: game)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                        .overlay(
                            NavigationLink(destination: GameView(viewModel: GameVM(emojiArray: game.iconsArray, cardsColor:game.bgColorCode)), label: {
                                // EmptyView()
                            }).opacity(0.0)
                        ).listRowBackground(Color.clear)

                }.listStyle(.plain)
                
            }.navigationTitle("Select Game").navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action : {
                    self.mode.wrappedValue.dismiss()
                }){
                    Image(systemName: "chevron.left")
                }).navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text("Choose Game").font(.title)
                        }
                    }
                }.foregroundColor(Color(hex: "#575859"))
        
        }.accentColor(Color(hex: "#575859")).onAppear(perform: viewModel.createListObjects)
        
    }
    

}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

