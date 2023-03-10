//
//  ThemeRow.swift
//  Memorizee
//
//  Created by Shruthi_ML on 18/12/22.
//

import SwiftUI

struct ThemeRow: View {
    
    var vm = SettingVM()
    var themeColorSet : ThemeColorSet
    
    @Binding var selectedTheme: ThemeColorSet?
    
    @Binding var selectedThemeID: Int
    
    
    var body: some View {
        
        HStack {
            Rectangle()
                .fill(Color(hex: themeColorSet.c1))
            Rectangle()
                .fill(Color(hex: themeColorSet.c2))
            Rectangle()
                .fill(Color(hex: themeColorSet.c3))
            Rectangle()
                .fill(Color(hex: themeColorSet.c4))
            Rectangle()
                .fill(Color(hex: themeColorSet.c5))
            
        }.frame(height: 20).padding(5)
            .border(themeColorSet.id == selectedThemeID ? Color("titleTxtColor") : Color.clear)
            .onTapGesture {
                self.selectedTheme = self.themeColorSet
                self.selectedThemeID = self.themeColorSet.id
            }
    }
}

//struct ThemeRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeRow(themeColorSet: ThemeColorSet(id: 0, c1: "FFA07A",c2: "FFA07A",c3: "FFA07A",c4: "FFA07A",c5: "FFA07A", isSelected: false))
//    }
//}
