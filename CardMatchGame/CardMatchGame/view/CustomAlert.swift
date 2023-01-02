//
//  CustomAlert.swift
//  Memorizee
//
//  Created by Shruthi_ML on 20/11/22.
//

import SwiftUI

/// A boolean State variable is required in order to present the view.
struct CustomAlert: View {
    
    /// Flag used to dismiss the alert on the presenting view
    @Binding var presentAlert: Bool
    
    /// The alert type being shown
    @State var alertType: AlertType = .success
    
    /// based on this value alert buttons will show vertically
    var isShowVerticalButtons = true
    
    var leftButtonAction: (() -> ())?
    var rightButtonAction: (() -> ())?
    
    let verticalButtonsHeight: CGFloat = 80
    
    var body: some View {
        
        ZStack {
            
            // faded background
            Color.black.opacity(0.25)
                .edgesIgnoringSafeArea(.all)
         
            VStack(spacing: 0) {
                
                if alertType.title() != "" {
                    
                    // alert title
                    //Text(alertType.title())
                    Text("Game Completed")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .frame(height: 25)
                        .padding(.top, 10)
                        .padding(.horizontal, 16)
                }
                
                LottieView(name: "game_complete_star", loopMode: .loop)
                    .frame(width: 250, height: 180).padding(.bottom, 25)
                
                
                
                if isShowVerticalButtons {
                    
                    HStack(spacing: 0) {
                        
                        VStack(spacing: 0) {
                            Spacer()
                            Button {
                                leftButtonAction?()
                            } label: {
                                Text(alertType.leftActionText)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.green)
                                    .multilineTextAlignment(.center)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            }
                            Spacer()
                            
                            Divider()
                            
                            Spacer()
                            Button {
                                rightButtonAction?()
                            } label: {
                                Text(alertType.rightActionText)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.green)
                                    .multilineTextAlignment(.center)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            }
                            Spacer()
                            
                        }
                        .frame(height: verticalButtonsHeight)
                        
                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 55)
                    .padding([.horizontal, .bottom], 0)
                    
                }

            }
           .frame(width: 270, height: alertType.height(isShowVerticalButtons: true))
            .background(
                Color.white
            )
            .cornerRadius(40)
        }

        }
        
    }



