//
//  UIView+Extension.swift
//  Medicine Reminder
//
//  Created by husayn on 17/08/2024.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
        }
    }
}
