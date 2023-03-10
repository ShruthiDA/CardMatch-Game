//
//  CardMatchGameApp.swift
//  CardMatchGame
//
//  Created by Shruthi_ML on 3/1/23.
//

import SwiftUI

@main
struct CardMatchGameApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            SplashView()
            //TicTacToeView()
        }
    }
}
