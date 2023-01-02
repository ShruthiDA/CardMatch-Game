//
//  MainVM.swift
//  Memorizee
//
//  Created by Shruthi_ML on 17/10/22.
//

import Foundation

class MainVM: ObservableObject {
    
    
    var flagArray = ["🇦🇫", "🇦🇽", "🇦🇱", "🇩🇿", "🇦🇸", "🇦🇩", "🇦🇴", "🇦🇮", "🇦🇶", "🇦🇬", "🇦🇷", "🇦🇲", "🇦🇺","🇦🇼", "🇦🇹", "🇦🇿", "🇧🇸"]
    var vehicleArray = ["🛺", "🚜", "🚛", "🚚", "🚗", "🚐", "🚒", "🚑", "🚓", "🚕", "🚙", "🚌", "🚎", "🏎", "🛵", "🏍"]
    var animalArray = ["🐶", "🐱", "🐭", "🐹", "🐰","🦊","🐻","🐼","🐻‍❄️","🦁","🐯","🐮","🐷","🐵","🐸"]
    var emoticonArray = ["😀", "😆", "🙃", "🙂", "🫤", "😌","😜","🤓","😉","🤣","😝","🤩","🥹","😎","😬","😐"]
    var snackArray = ["🍕", "🍟", "🍔", "🌭","🧁", "🥮", "🍫", "🌮","🎂","🥞","🥐","🧀","🍗","🍧","🍿","🍩","🥨","🍡"]
    
    
    @Published var gameTypeModelList : [GameTypeModel] = []
    
    func createListObjects(){
        
        let settingVM = SettingVM()
        let themeID = UserDefaults.standard.integer(forKey: "selectedThemeID")
        print("theme id is \(themeID)")
        let theme : ThemeColorSet = settingVM.getThemeById(id: themeID)
        
        let g1 =   GameTypeModel(id: 1, gameName: "Match Flags", iconsArray: flagArray, bgColorCode: theme.c1, fgColorCode: "000000")
        
        let g2 = GameTypeModel(id: 2, gameName: "Match Vehicles", iconsArray: vehicleArray,bgColorCode: theme.c2, fgColorCode: "000000")
        
        let g3 = GameTypeModel(id: 3, gameName: "Match Animals", iconsArray: animalArray,bgColorCode: theme.c3, fgColorCode: "000000")
        
        let g4 = GameTypeModel(id: 4, gameName: "Match Emojis", iconsArray: emoticonArray,bgColorCode: theme.c4, fgColorCode: "000000")
        
        let g5 = GameTypeModel(id: 5, gameName: "Match Food", iconsArray: snackArray, bgColorCode: theme.c5, fgColorCode: "000000")
       
    
        self.gameTypeModelList = [g1,g2,g3,g4,g5]
    
    }
    
}
