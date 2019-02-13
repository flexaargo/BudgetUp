//
//  AddActionView.swift
//  BudgetUp
//
//  Created by Alex Fargo on 2/11/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

class AddActionView: UIView {
  
  let titleTextField: UITextField = {
    let textField = UITextField()
    
    textField.textColor = Color.darkText.value
    textField.placeholder = "Title"
    textField.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    textField.layer.cornerRadius = 6
    textField.returnKeyType = .done
    
    textField.translatesAutoresizingMaskIntoConstraints = false
    
    return textField
  }()
  
  let forLabel: UILabel = {
    let label = UILabel()
    
    label.text = "For?"
    label.textColor = Color.darkText.value
    label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  let howMuchLabel: UILabel = {
    let label = UILabel()
    
    label.text = "How much?"
    label.textColor = Color.darkText.value
    label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  let whenLabel: UILabel = {
    let label = UILabel()
    
    label.text = "When?"
    label.textColor = Color.darkText.value
    label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  let detailsTextView: UITextView = {
    let textView = UITextView()
    
    let padding = UIEdgeInsets(top: 5, left: 3, bottom: 5, right: 3)
    textView.textContainerInset = padding
    
    textView.textColor = Color.lightText.value
    textView.text = "Any details?"
    textView.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    textView.layer.cornerRadius = 6
    
    textView.translatesAutoresizingMaskIntoConstraints = false
    
    return textView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(titleTextField)
    addSubview(forLabel)
    addSubview(howMuchLabel)
    addSubview(whenLabel)
    addSubview(detailsTextView)
    
    setupLayout()
  }
  
  override func layoutSubviews() {
    setupLayout()
  }
  
  private func setupLayout() {
    NSLayoutConstraint.activate([
      titleTextField.topAnchor.constraint(equalTo: topAnchor, constant: 16),
      titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      titleTextField.heightAnchor.constraint(equalToConstant: 34)
      ])
    
    NSLayoutConstraint.activate([
      forLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 8),
      forLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      forLabel.heightAnchor.constraint(equalToConstant: 26)
      ])
    
    NSLayoutConstraint.activate([
      howMuchLabel.topAnchor.constraint(equalTo: forLabel.bottomAnchor, constant: 8),
      howMuchLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      howMuchLabel.heightAnchor.constraint(equalToConstant: 26)
      ])
    
    NSLayoutConstraint.activate([
      whenLabel.topAnchor.constraint(equalTo: howMuchLabel.bottomAnchor, constant: 8),
      whenLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      whenLabel.heightAnchor.constraint(equalToConstant: 26)
      ])
    
    NSLayoutConstraint.activate([
      detailsTextView.topAnchor.constraint(equalTo: whenLabel.bottomAnchor, constant: 8),
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
