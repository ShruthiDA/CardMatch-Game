//
//  SettingVM.swift
//  Memorizee
//
//  Created by Shruthi_ML on 18/12/22.
//

import Foundation
import SwiftUI

class SettingVM : ObservableObject{
    
    @Published var themeList:[ThemeColorSet]
    
    init(){
        let t1 = ThemeColorSet(id: 1, c1: "CAE7E3",c2: "B2B2B2",c3: "EEB8C5",c4: "DCDBD9",c5: "F7F6CF")
        let t2 = ThemeColorSet(id: 5, c1: "e8dff5",c2: "FCF4DD",c3: "ddedea",c4: "daeaf6",c5: "fcefe4")
        let t3 = ThemeColorSet(id: 3, c1: "A8E6CE",c2: "DCEDC2",c3: "FED3B5",c4: "FFAAA6",c5: "FE8C94")
        let t4 = ThemeColorSet(id: 4, c1: "EDDCD2",c2: "FC9D9A",c3: "DDEDEA",c4: "C8C8A9",c5: "FFA07A")
        let t5 = ThemeColorSet(id: 2, c1: "FECCBB",c2: "6EB5C0",c3: "E2E8E4",c4: "90AFC5",c5: "A8E0CC")

        self.themeList = [t1,t2,t3,t4,t5]
    }
    
    func getThemeById(id: Int) -> ThemeColorSet{
        for i in 0..<themeList.count{
            if(themeList[i].id == id){
                return themeList[i]
            }
        }
        return themeList[0]
    }
    
}
