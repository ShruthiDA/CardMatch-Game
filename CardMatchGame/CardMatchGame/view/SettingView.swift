//
//  SettingView.swift
//  Memorizee
//
//  Created by Shruthi_ML on 18/12/22.
//

import SwiftUI

struct SettingView: View {
    
    @ObservedObject
    var viewmodel = SettingVM()
    
    
    @State var selectedTheme: ThemeColorSet? = ThemeColorSet(id: 1, c1: "CAE7E3",c2: "B2B2B2",c3: "EEB8C5",c4: "DCDBD9",c5: "F7F6CF")
    
    @AppStorage("selectedThemeID") private var themeID = 1
    
    //Save sound setting in user default; AppStorage is property wrapper for user default
    @AppStorage("isSoundOn") private var isSoundEnabled = true
    
    //To handle back
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        
        VStack {
        
            VStack {
                
                Toggle(isOn: $isSoundEnabled) {
                    Text("Sound Enabled")
                }
                Image(systemName: isSoundEnabled ? "speaker.1.fill" : "speaker.slash.fill")
                    .font(.system(size: 56))
                    .padding()
            }.padding()
            
            
            VStack(alignment: .leading) {
                Text("Choose Theme").padding(.leading, 20)
                
                List{
                    ForEach(viewmodel.themeList) { theme in
                        
                        ThemeRow(themeColorSet: theme, selectedTheme: self.$selectedTheme, selectedThemeID: $themeID)
                                                .listRowSeparator(.hidden)
                                              .listRowBackground(Color.white)
                        
            
                    }
                }.frame(maxWidth: .infinity)
                                .edgesIgnoringSafeArea(.all)
                                .listStyle(PlainListStyle()).background(Color.white)
                
                
                

                
            }
        }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                Image(systemName: "chevron.left")
            }).navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Settings").font(.title)
                    }
                }
            }.foregroundColor(Color(hex: "#575859"))
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
