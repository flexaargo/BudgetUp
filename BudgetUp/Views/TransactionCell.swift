//
//  TransactionCell.swift
//  BudgetUp
//
//  Created by Alex Fargo on 2/8/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {
  
  var transaction: Transaction?
  
  let titleLabel: UILabel = {
    let label = UILabel()
    
    label.font = UIFont.systemFont(ofSize: 20)
    label.textColor = Color.darkText.value
    
    label.text = "Lunch with friends"
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  let amountLabel: UILabel = {
    let label = UILabel()
    
    label.font = UIFont.systemFont(ofSize: 20)
    label.textColor = Color.darkText.value
    
    label.text = "-$10.24"
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  let categoryLabel: UILabel = {
    let label = UILabel()
    
    label.font = UIFont.systemFont(ofSize: 15)
    label.textColor = Color.lightText.value
    
    label.text = "Food"
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = .red
    
    translatesAutoresizingMaskIntoConstraints = false
    
    setupLayout()
  }
  
  /// Setup the layout inside of this cell
  private func setupLayout() {
    addSubview(titleLabel)
    addSubview(amountLabel)
    addSubview(categoryLabel)
    
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: amountLabel.leadingAnchor, constant: -8),
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.heightAnchor.constraint(equalToConstant: 24)
      ])
    
    NSLayoutConstraint.activate([
      amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      amountLabel.topAnchor.constraint(equalTo: topAnchor),
      amountLabel.heightAnchor.constraint(equalToConstant: 24)
      ])
    
    NSLayoutConstraint.activate([
      categoryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      categoryLabel.trailingAnchor.constraint(lessThanOrEqualTo: amountLabel.trailingAnchor),
      categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
      categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
      ])
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
