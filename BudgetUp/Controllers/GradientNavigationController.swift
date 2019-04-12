//
//  GradientNavigationController.swift
//  BudgetUp
//
//  Created by Alex Fargo on 4/11/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

class GradientNavigationController: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let gradient = CAGradientLayer()
    var bounds = navigationBar.bounds
    bounds.size.height += UIApplication.shared.statusBarFrame.size.height
    gradient.frame = bounds
    gradient.colors = [Color.primaryDark.value.cgColor, Color.primaryLight.value.cgColor]
    gradient.startPoint = CGPoint(x: 0, y: 1)
    gradient.endPoint = CGPoint(x: 1, y: 0)
    
    if let image = getImageFrom(gradientLayer: gradient) {
      navigationBar.setBackgroundImage(image, for: .default)
    }
  }
  
  func getImageFrom(gradientLayer: CAGradientLayer) -> UIImage? {
    var gradientImage: UIImage?
    UIGraphicsBeginImageContext(gradientLayer.frame.size)
    if let context = UIGraphicsGetCurrentContext() {
      gradientLayer.render(in: context)
      gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: .zero, resizingMode: .stretch)
    }
    UIGraphicsEndImageContext()
    return gradientImage
  }
  
}
