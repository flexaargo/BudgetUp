//
//  AddTransactionView.swift
//  BudgetUp
//
//  Created by Alex Fargo on 2/11/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

class AddTransactionView: UIView {
  
  let titleTextField: UITextField = {
    let textField = UITextField()
    
    textField.textColor = Color.darkText.value
    textField.placeholder = "Title"
    textField.font = UIFont.systemFont(ofSize: 24, weight: .medium)
    textField.layer.cornerRadius = 6
    textField.returnKeyType = .done
    
    textField.translatesAutoresizingMaskIntoConstraints = false
    
    return textField
  }()
  
  let cancelButton: UIButton = {
    let button = UIButton()
    
    button.setImage(UIImage(named: "cancelX"), for: .normal)
    
    button.translatesAutoresizingMaskIntoConstraints = false
    
    return button
  }()
  
  let detailsTextView: UITextView = {
    let textView = UITextView()
    
    let padding = UIEdgeInsets(top: 5, left: 3, bottom: 5, right: 3)
    textView.textContainerInset = padding
    
    textView.textColor = Color.lightText.value
    textView.text = "Details"
    textView.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    textView.layer.cornerRadius = 6
    
    textView.translatesAutoresizingMaskIntoConstraints = false
    
    return textView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(titleTextField)
    addSubview(cancelButton)
    addSubview(detailsTextView)
    
    setupLayout()
  }
  
  override func layoutSubviews() {
    setupLayout()
  }
  
  private func setupLayout() {
    NSLayoutConstraint.activate([
      cancelButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
      cancelButton.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
      cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      cancelButton.widthAnchor.constraint(equalTo: cancelButton.heightAnchor, multiplier: 1)
      ])
    
    NSLayoutConstraint.activate([
      titleTextField.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 16),
      titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      titleTextField.heightAnchor.constraint(equalToConstant: 34)
      ])
    
    NSLayoutConstraint.activate([
      detailsTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 8),
      detailsTextView.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
      detailsTextView.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
      detailsTextView.heightAnchor.constraint(equalToConstant: 200),
      detailsTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
      ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
