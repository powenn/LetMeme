//
//  UIApplication.swift
//  LetMeme
//
//  Created by 蕭博文 on 2024/1/30.
//

import Foundation
import UIKit

extension UIApplication {
    // 3
    var firstKeyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.activationState == .foregroundActive }
            .first?.keyWindow
    }
}
