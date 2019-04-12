//
//  SummaryView.swift
//  BudgetUp
//
//  Created by Alex Fargo on 2/7/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

class SummaryView: UIView {
  let summaryLabel: UILabel = {
    let label = UILabel()
    
    label.text = "Summary"
    label.textColor = Color.darkText.value
    label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  let summaryCard: UIView = {
    let view = UIView()
    
    view.backgroundColor = .white
    view.layer.cornerRadius = 6
    view.dropShadow(alpha: 0.2, x: 0, y: 2, blur: 4, spread: 0)
    
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  let editButton: UIButton = {
    let button = UIButton(type: .custom)
    
    button.setImage(#imageLiteral(resourceName: "editIcon"), for: .normal)
    
    button.translatesAutoresizingMaskIntoConstraints = false
    
    return button
  }()
  
  let summaryTextView: UITextView = {
    let textView = UITextView()
    
    textView.isEditable = false
    textView.isSelectable = false
    textView.isScrollEnabled = false
    textView.textColor = Color.darkText.value
    
    textView.translatesAutoresizingMaskIntoConstraints = false
    
    return textView
  }()
  
  let remainingLabel: UILabel = {
    let label = UILabel()
    
    label.text = "Remaining"
    label.font = UIFont.systemFont(ofSize: 18)
    label.textColor = Color.lightText.value
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    translatesAutoresizingMaskIntoConstraints = false
    
    
    addSubview(summaryLabel)
    addSubview(summaryCard)
    summaryCard.addSubview(summaryTextView)
    summaryCard.addSubview(remainingLabel)
    summaryCard.addSubview(editButton)
    
    setupLayout()
  }
  
  override func layoutSubviews() {
    setupLayout()
  }
  
  /// Setup the layout in the summary view
  private func setupLayout() {
    
    NSLayoutConstraint.activate([
      summaryLabel.topAnchor.constraint(equalTo: topAnchor),
      summaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      summaryLabel.bottomAnchor.constraint(equalTo: summaryCard.topAnchor, constant: -8),
      summaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
    
    NSLayoutConstraint.activate([
      summaryCard.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 8),
      summaryCard.leadingAnchor.constraint(equalTo: leadingAnchor),
      summaryCard.bottomAnchor.constraint(equalTo: bottomAnchor),
      summaryCard.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
    
    NSLayoutConstraint.activate([
      editButton.topAnchor.constraint(equalTo: summaryCard.topAnchor, constant: 4),
      editButton.trailingAnchor.constraint(equalTo: summaryCard.trailingAnchor, constant: -4),
      editButton.widthAnchor.constraint(equalTo: editButton.heightAnchor)
    ])
    
    NSLayoutConstraint.activate([
      summaryTextView.leadingAnchor.constraint(equalTo: summaryCard.leadingAnchor, constant: 8),
      summaryTextView.trailingAnchor.constraint(greaterThanOrEqualTo: summaryCard.trailingAnchor, constant: -8),
      summaryTextView.topAnchor.constraint(equalTo: summaryCard.topAnchor, constant: 8),
      summaryTextView.heightAnchor.constraint(equalToConstant: 60)
      ])
    
    NSLayoutConstraint.activate([
      remainingLabel.leadingAnchor.constraint(equalTo: summaryTextView.leadingAnchor),
      remainingLabel.trailingAnchor.constraint(equalTo: summaryTextView.trailingAnchor),
      remainingLabel.topAnchor.constraint(equalTo: summaryTextView.bottomAnchor, constant: 4),
      remainingLabel.bottomAnchor.constraint(equalTo: summaryCard.bottomAnchor, constant: -8),
      ])
  }
  
  func setSummaryText(_ budgetInfo: BudgetInfo) {
    let availableBalance = Double(budgetInfo.budget) + budgetInfo.difference
    
    let currentLocale = NSLocale.current
    let currencySymbol = currentLocale.currencySymbol!
    
    let sign = (availableBalance < 0) ? "-" : ""
    
    let centValue = availableBalance.truncatingRemainder(dividingBy: 1).magnitude
    let centFormatter = NumberFormatter()
    centFormatter.minimumFractionDigits = 2
    centFormatter.minimumIntegerDigits = 0
    
    let primaryAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 50.0, weight: .semibold)]
    let secondaryAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25.0, weight: .medium)]
    
    let summary = NSMutableAttributedString()
    // currency symbol
    summary.append(NSAttributedString(string: currencySymbol, attributes: secondaryAttributes))
    // available
    summary.append(NSAttributedString(string: sign + String(Int(floor(availableBalance.magnitude))), attributes: primaryAttributes))
    // rest of the summary
    let restOfSummary = centFormatter.string(for: centValue)! + " / " + currencySymbol + String(budgetInfo.budget)
    summary.append(NSAttributedString(string: restOfSummary, attributes: secondaryAttributes))
    
    summaryTextView.attributedText = summary
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
