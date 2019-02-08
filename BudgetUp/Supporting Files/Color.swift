//
//  Color.swift
//  BudgetUp
//
//  Created by Alex Fargo on 2/7/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

enum Color {
  case primaryLight
  case primaryDark
  
  case border
  case shadow
  
  case lightBackground
  case darkBackground
  
  case lightText
  case darkText
  
  case affirmation
  case negation
  
  case custom(hexString: String, alpha: Double)
  
  func withAlpha(_ alpha: Double) -> UIColor {
    return self.value.withAlphaComponent(CGFloat(alpha))
  }
}

extension Color {
  var value: UIColor {
    var instanceColor = UIColor.clear
    
    switch self {
    case .primaryLight:
      instanceColor = UIColor(hexString: "2ECC71")
    case .primaryDark:
      instanceColor = UIColor(hexString: "27AE60")
    case .border:
      instanceColor = UIColor(hexString: "4A4A4A")
    case .shadow:
      instanceColor = UIColor(hexString: "000000")
    case .lightBackground:
      instanceColor = UIColor(hexString: "F0F0F0")
    case .darkBackground:
      instanceColor = UIColor(hexString: "2C3E50")
    case .lightText:
      instanceColor = UIColor(hexString: "95A5A6")
    case .darkText:
      instanceColor = UIColor(hexString: "2E3131")
    case .affirmation:
      instanceColor = UIColor(hexString: "5333ED")
    case .negation:
      instanceColor = UIColor(hexString: "F03434")
    case .custom(hexString: let hexValue, alpha: let opacity):
      instanceColor = UIColor(hexString: hexValue).withAlphaComponent(CGFloat(opacity))
    }
    
    return instanceColor
  }
}

extension UIColor {
  // Creates a UIColor from HEX String in "#363636" format
  // - parameter hexString: HEX String in "#363636" format
  //
  // - returns: UIColor from HexString
  
  convenience init(hexString: String) {
    let hexString: String = (hexString as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
    let scanner = Scanner(string: hexString as String)
    
    if hexString.hasPrefix("#") {
      scanner.scanLocation = 1
    }
    
    var color: UInt32 = 0
    scanner.scanHexInt32(&color)
    
    let mask = 0x000000FF
    let r = Int(color >> 16) & mask
    let g = Int(color >> 8) & mask
    let b = Int(color) & mask
    
    let red = CGFloat(r) / 255.0
    let green = CGFloat(g) / 255.0
    let blue = CGFloat(b) / 255.0
    self.init(red: red, green: green, blue: blue, alpha: 1)
  }
  
  // Creates a UIColor Object based on provided RGB value in integer
  // - parameter red: Red Value in integer (0-255)
  // - parameter green: Green Value in integer (0-255)
  // - parameter blue: Blue Value in integer (0-255)
  //
  // - returns: UIColor with specified RGB values
  
  convenience init(red: Int, green: Int, blue: Int) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")
    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1)
  }
  
}
