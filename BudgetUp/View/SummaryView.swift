//
//  SummaryView.swift
//  BudgetUp
//
//  Created by Alex Fargo on 2/7/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

class SummaryView: UIView {
  private let summaryTextView: UITextView = {
    let textView = UITextView()
    
    textView.isEditable = false
    textView.isSelectable = false
    textView.isScrollEnabled = false
    textView.textColor = Color.darkText.value
    
    // DEBUG
//    textView.backgroundColor = .yellow
    
    textView.translatesAutoresizingMaskIntoConstraints = false
    
    return textView
  }()
  
  private let remainingLabel: UILabel = {
    let label = UILabel()
    
    label.text = "Remaining"
    label.font = UIFont.systemFont(ofSize: 18)
    label.textColor = Color.lightText.value
    
    // DEBUG
//    label.backgroundColor = .blue
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    

    backgroundColor = .white
    layer.cornerRadius = 6
    dropShadow(alpha: 0.5, x: 0, y: 2, blur: 4, spread: 0)
    
    translatesAutoresizingMaskIntoConstraints = false
    
    // DEBUG
    //    backgroundColor = .red
    
    setupLayout()
  }
  
  private func setupLayout() {
    addSubview(summaryTextView)
    addSubview(remainingLabel)
    
    NSLayoutConstraint.activate([
      summaryTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
      summaryTextView.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: -8),
      summaryTextView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
      summaryTextView.heightAnchor.constraint(equalToConstant: 60)
      ])
    
    NSLayoutConstraint.activate([
      remainingLabel.leadingAnchor.constraint(equalTo: summaryTextView.leadingAnchor),
      remainingLabel.trailingAnchor.constraint(equalTo: summaryTextView.trailingAnchor),
      remainingLabel.topAnchor.constraint(equalTo: summaryTextView.bottomAnchor),
      remainingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
      ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
