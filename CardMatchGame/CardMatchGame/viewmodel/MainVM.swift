//
//  MainVM.swift
//  Memorizee
//
//  Created by Shruthi_ML on 17/10/22.
//

import Foundation

class MainVM: ObservableObject {
    
    
    var alphabtesArray = ["letter_a", "letter_b", "letter_c", "letter_d","letter_e", "letter_f", "letter_g", "letter_h","letter_i","letter_j","letter_k","letter_l","letter_m","letter_n","letter_o",
                     "letter_q","letter_r","letter_s","letter_t","letter_u","letter_v","letter_w","letter_x",
                     "letter_y","letter_z"]
    
    var animalsArray = ["animal_a", "animal_b", "animal_c", "animal_d","animal_e", "animal_f", "animal_g", "animal_h","animal_i","animal_j","animal_k","animal_l","animal_m","animal_n","animal_o",
                     "animal_q","animal_r","animal_s","animal_t","animal_u","animal_v","animal_w","animal_x",
                     "animal_y","animal_z"]
    
    var fruitsArray = ["fruits_1", "fruits_2", "fruits_3", "fruits_4","fruits_5", "fruits_6", "fruits_7", "fruits_8","fruits_9","fruits_10","fruits_11","fruits_12","fruits_13","fruits_14","fruits_15",
                     "fruits_16","fruits_17","fruits_18"]
    
    var vegitablesArray = ["veg_1", "veg_2", "veg_3", "veg_4","veg_5", "veg_6", "veg_7", "veg_8","veg_9","veg_10",
                      "veg_11","veg_12","veg_13","veg_14","veg_15","veg_16","veg_17","veg_18","veg_19"]
    
    var vehiclesArray = ["vehicle_1", "vehicle_2", "vehicle_3", "vehicle_4","vehicle_5", "vehicle_6", "vehicle_7","vehicle_8","vehicle_9","vehicle_10","vehicle_11","vehicle_12","vehicle_13","vehicle_14","vehicle_15","vehicle_16","vehicle_17","vehicle_18","vehicle_19"]
    
    @Published var gameTypeModelList : [GameTypeModel] = []
    
    
    func createListObjects(){
        
        let settingVM = SettingVM()
        let themeID = UserDefaults.standard.integer(forKey: "selectedThemeID")
        print("theme id is \(themeID)")
        let theme : ThemeColorSet = settingVM.getThemeById(id: themeID)
        
       
        let g1 = GameTypeModel(id: 1, gameName: "Match Alphabets",  bgColorCode: theme.c1, fgColorCode: "000000", gameVM: GameVM(emojiArray: alphabtesArray, cardsColor: theme.c1, gameName: "Match Alphabets"))
       
        let g2 = GameTypeModel(id: 2, gameName: "Match Vegitables",bgColorCode: theme.c2, fgColorCode: "000000", gameVM: GameVM(emojiArray: vegitablesArray, cardsColor: theme.c2, gameName: "Match Vegitables" ))
       
        let g3 = GameTypeModel(id: 3, gameName: "Match Fruits",bgColorCode: theme.c3, fgColorCode: "000000", gameVM: GameVM(emojiArray: fruitsArray, cardsColor: theme.c3, gameName: "Match Fruits" ))
       
        let g4 = GameTypeModel(id: 4, gameName: "Match Vehicles", bgColorCode: theme.c4, fgColorCode: "000000", gameVM: GameVM(emojiArray: vehiclesArray, cardsColor: theme.c4, gameName: "Match Vehicles" ))
       
        let g5 = GameTypeModel(id: 5, gameName: "Match Animals", bgColorCode: theme.c5, fgColorCode: "000000", gameVM: GameVM(emojiArray: animalsArray, cardsColor: theme.c5, gameName: "Match Animals" ))
       
        
        self.gameTypeModelList = [g1, g2, g3, g4, g5]
        
    }
    
}
