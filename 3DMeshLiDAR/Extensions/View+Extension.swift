//
//  View+Extension.swift
//  3DMeshLiDAR
//
//  Created by Mahesh on 23/08/23.
//

import UIKit

extension UIView {
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
