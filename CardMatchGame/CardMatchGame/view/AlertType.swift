//
//  AlertType.swift
//  Memorizee
//
//  Created by Shruthi_ML on 20/11/22.
//

import SwiftUI

/// Alert type
enum AlertType {
    
    case success
    case error(title: String, message: String = "")
    
    func title() -> String {
        switch self {
        case .success:
            return "Success"
        case .error(title: let title, _):
            return title
        }
    }
    
    func message() -> String {
        switch self {
        case .success:
            return ""
        case .error(_, message: let message):
            return message
        }
    }
    
    /// Left button action text for the alert view
    var leftActionText: String {
        switch self {
        case .success:
            return "Play Again"
        case .error(_, _):
            return "Go"
        }
    }
    
    /// Right button action text for the alert view
    var rightActionText: String {
        switch self {
        case .success:
            return "Select New Game"
        case .error(_, _):
            return "Cancel"
        }
    }
    
    func height(isShowVerticalButtons: Bool = false) -> CGFloat {
        return 330
//     switch self {
//        case .success:
//            return isShowVerticalButtons ? 400 : 400
//        case .error(_, _):
//            return isShowVerticalButtons ? 220 : 350
//        }
    }
}
