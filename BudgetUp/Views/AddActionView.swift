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
    textField.attributedPlaceholder = NSAttributedString(string: "Title", attributes: [
      NSAttributedString.Key.foregroundColor: Color.lightText.value,
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .semibold)
      ])
    textField.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
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
  
  let categoryField: UITextField = {
    let textField = UITextField()
    
    textField.textColor = Color.darkText.value
    textField.attributedPlaceholder = NSAttributedString(string: "Choose a category", attributes: [
      NSAttributedString.Key.foregroundColor: Color.lightText.value,
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .medium)
      ])
    textField.font = UIFont.systemFont(ofSize: 22, weight: .medium)
    textField.textAlignment = .right
    
    textField.translatesAutoresizingMaskIntoConstraints = false
    
    return textField
  }()
  
  let howMuchLabel: UILabel = {
    let label = UILabel()
    
    label.text = "How much?"
    label.textColor = Color.darkText.value
    label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  let amountField: CurrencyField = {
    let textField = CurrencyField()
    
    textField.textColor = Color.darkText.value
    textField.attributedPlaceholder = NSAttributedString(string: "$0.00", attributes: [
      NSAttributedString.Key.foregroundColor: Color.lightText.value,
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .medium)
      ])
    textField.font = UIFont.systemFont(ofSize: 22, weight: .medium)
    textField.textAlignment = .right
    
    textField.translatesAutoresizingMaskIntoConstraints = false
    
    return textField
  }()
  
  let whenLabel: UILabel = {
    let label = UILabel()
    
    label.text = "When?"
    label.textColor = Color.darkText.value
    label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  let dateField: UITextField = {
    let textField = UITextField()
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, yyyy"
    
    textField.textColor = Color.darkText.value
    
    textField.attributedPlaceholder = NSAttributedString(string: dateFormatter.string(from: currentDate), attributes: [
      NSAttributedString.Key.foregroundColor: Color.lightText.value,
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .medium)
      ])
    textField.font = UIFont.systemFont(ofSize: 22, weight: .medium)
    textField.textAlignment = .right
    
    textField.translatesAutoresizingMaskIntoConstraints = false
    
    return textField
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
    addSubview(categoryField)
    addSubview(howMuchLabel)
    addSubview(amountField)
    addSubview(whenLabel)
    addSubview(dateField)
    addSubview(detailsTextView)
    
    setupLayout()
  }
  
//  override func layoutSubviews() {
//    setupLayout()
//  }
  
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
      categoryField.leadingAnchor.constraint(greaterThanOrEqualTo: forLabel.trailingAnchor, constant: 8),
      categoryField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      categoryField.topAnchor.constraint(equalTo: forLabel.topAnchor),
      categoryField.bottomAnchor.constraint(equalTo: forLabel.bottomAnchor)
      ])
    
    NSLayoutConstraint.activate([
      howMuchLabel.topAnchor.constraint(equalTo: forLabel.bottomAnchor, constant: 8),
      howMuchLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      howMuchLabel.heightAnchor.constraint(equalToConstant: 26)
      ])
    
    NSLayoutConstraint.activate([
      amountField.leadingAnchor.constraint(greaterThanOrEqualTo: howMuchLabel.trailingAnchor, constant: 8),
      amountField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      amountField.topAnchor.constraint(equalTo: howMuchLabel.topAnchor),
      amountField.bottomAnchor.constraint(equalTo: howMuchLabel.bottomAnchor)
      ])
    
    NSLayoutConstraint.activate([
      whenLabel.topAnchor.constraint(equalTo: howMuchLabel.bottomAnchor, constant: 8),
      whenLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      whenLabel.heightAnchor.constraint(equalToConstant: 26)
      ])
    
    NSLayoutConstraint.activate([
      dateField.leadingAnchor.constraint(greaterThanOrEqualTo: whenLabel.trailingAnchor, constant: 8),
      dateField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      dateField.topAnchor.constraint(equalTo: whenLabel.topAnchor),
      dateField.bottomAnchor.constraint(equalTo: whenLabel.bottomAnchor)
      ])
    
    NSLayoutConstraint.activate([
      detailsTextView.topAnchor.constraint(equalTo: whenLabel.bottomAnchor, constant: 16),
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

class CurrencyField: UITextField {
  var string: String { return text ?? "" }
  var decimal: Decimal {
    return string.digits.decimal / Decimal(pow(10, Double(Formatter.currency.maximumFractionDigits)))
  }
  var decimalNumber: NSDecimalNumber { return decimal.number }
  var doubleValue: Double { return decimalNumber.doubleValue }
  var integerValue: Int { return decimalNumber.intValue }
  let maximum: Decimal = 999_999.99
  private var lastValue: String?
  
  override func willMove(toSuperview newSuperview: UIView?) {
    addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    keyboardType = .numberPad
    textAlignment = .right
  }
  
  override func deleteBackward() {
    text = string.digits.dropLast().string
    editingChanged()
  }
  
  @objc func editingChanged(_ textField: UITextField? = nil) {
    guard decimal <= maximum else {
      text = lastValue
      return
    }
    text = Formatter.currency.string(for: decimal)
    if text == Formatter.currency.string(from: 0) {
      text = nil
    }
    lastValue = text
  }
}

extension NumberFormatter {
  convenience init(numberStyle: Style) {
    self.init()
    self.numberStyle = numberStyle
  }
}

extension Formatter {
  static let currency = NumberFormatter(numberStyle: .currency)
}

extension String {
  var digits: [UInt8] {
    return map(String.init).compactMap(UInt8.init)
  }
}

extension Collection where Element == UInt8 {
  var string: String { return map(String.init).joined() }
  var decimal: Decimal { return Decimal(string: string) ?? 0 }
}

extension Decimal {
  var number: NSDecimalNumber { return NSDecimalNumber(decimal: self) }
}
