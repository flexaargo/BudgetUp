//
//  Shadow.swift
//  BudgetUp
//
//  Created by Alex Fargo on 2/7/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

extension UIView {
  func dropShadow(alpha: Float, x: CGFloat, y: CGFloat, blur: CGFloat, spread: CGFloat) {
    layer.masksToBounds = false
    layer.applySketchShadow(color: Color.shadow.value, alpha: alpha, x: x, y: y, blur: blur, spread: spread)
  }
}

extension CALayer {
  func applySketchShadow(color: UIColor = .black, alpha: Float = 0.5, x: CGFloat = 0, y: CGFloat = 2, blur: CGFloat = 4, spread: CGFloat = 0) {
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 2.0
    if spread == 0 {
      shadowPath = nil
    } else {
      let dx = -spread
      let rect = bounds.insetBy(dx: dx, dy: dx)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
  }
}
