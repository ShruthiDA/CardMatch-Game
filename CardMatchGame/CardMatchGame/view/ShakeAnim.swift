//
//  ShakeAnim.swift
//  Memorizee
//
//  Created by Shruthi_ML on 16/10/22.
//

import Foundation
import SwiftUI

struct ShakeAnim: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
                                                amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
                                              y: 0))
    }
}
