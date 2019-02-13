//
//  TransactionCell.swift
//  BudgetUp
//
//  Created by Alex Fargo on 2/8/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {
  
  var transaction: Transaction? {
    didSet {
      let currentLocale = NSLocale.current
      let currencySymbol = currentLocale.currencySymbol!
      let sign = transaction!.transactionCategoryEnum == .deposit ? "+" : "-"
      
      titleLabel.text = transaction!.title
      amountLabel.text = sign + currencySymbol + String(format: "%.2f", transaction!.amount.magnitude)
      categoryLabel.text = transaction!.transactionCategory.capitalized(with: currentLocale)
    }
  }
  
  let cellBackground: UIView = {
    let view = UIView()
    
    view.backgroundColor = .white
    view.layer.cornerRadius = 6
    view.dropShadow(alpha: 0.2, x: 0, y: 2, blur: 4, spread: 0)
    
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    
    label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
    label.textColor = Color.darkText.value
    
    label.text = "D:"
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  let amountLabel: UILabel = {
    let label = UILabel()
    
    label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    label.textColor = Color.darkText.value
    
    label.text = "D:"
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  let categoryLabel: UILabel = {
    let label = UILabel()
    
    label.font = UIFont.systemFont(ofSize: 15)
    label.textColor = Color.lightText.value
    
    label.text = "D:"
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = .clear
    selectionStyle = .none
    
    addSubview(cellBackground)
    cellBackground.addSubview(titleLabel)
    cellBackground.addSubview(amountLabel)
    cellBackground.addSubview(categoryLabel)
    
    setupLayout()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupLayout()
  }
  
  /// Setup the layout inside of this cell
  private func setupLayout() {
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: -16),
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16)
      ])
    
    NSLayoutConstraint.activate([
      amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      amountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
      amountLabel.heightAnchor.constraint(equalToConstant: 24)
      ])

    NSLayoutConstraint.activate([
      categoryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      categoryLabel.trailingAnchor.constraint(lessThanOrEqualTo: amountLabel.trailingAnchor),
      categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
      categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
      ])
    
    NSLayoutConstraint.activate([
      cellBackground.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -8),
      cellBackground.trailingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: 8),
      cellBackground.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8),
      cellBackground.bottomAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8)
      ])
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    UIView.animate(withDuration: animated ? 0.5 : 0.0) {
      if selected {
        self.cellBackground.backgroundColor = Color.lightBackground.value
      } else {
        self.cellBackground.backgroundColor = .white
      }
    }
  }
  
  override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    super.setHighlighted(highlighted, animated: animated)

    UIView.animate(withDuration: animated ? 0.5 : 0.0) {
      if highlighted {
        self.cellBackground.backgroundColor = Color.lightBackground.value
      } else {
        self.cellBackground.backgroundColor = .white
      }
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
