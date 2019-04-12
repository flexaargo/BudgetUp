//
//  EditBudgetView.swift
//  BudgetUp
//
//  Created by Alex Fargo on 4/11/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

class EditBudgetView: UIView {
  let budgetLabel: UILabel = {
    let label = UILabel()
    
    label.text = "Budget"
    label.textColor = Color.darkText.value
    label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  let budgetField: CurrencyField = {
    let textField = CurrencyField()
    
    textField.textColor = Color.darkText.value
    textField.attributedPlaceholder = NSAttributedString(string: "$0", attributes: [
      NSAttributedString.Key.foregroundColor: Color.lightText.value,
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 50, weight: .medium)
      ])
    textField.font = UIFont.systemFont(ofSize: 50, weight: .medium)
    textField.textAlignment = .right
    textField.maximum = 10_000
    textField.integerOnly = true
    
    textField.translatesAutoresizingMaskIntoConstraints = false
    
    return textField
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(budgetLabel)
    addSubview(budgetField)
    
    setupLayout()
  }
  
  func setupLayout() {
    NSLayoutConstraint.activate([
      budgetLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
      budgetLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
    ])
    
    NSLayoutConstraint.activate([
      budgetField.topAnchor.constraint(equalTo: budgetLabel.bottomAnchor, constant: 8),
      budgetField.trailingAnchor.constraint(equalTo: budgetLabel.trailingAnchor)
    ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
