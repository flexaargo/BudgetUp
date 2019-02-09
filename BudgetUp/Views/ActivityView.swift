//
//  ActivityView.swift
//  BudgetUp
//
//  Created by Alex Fargo on 2/8/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

class ActivityView: UIView {
  private let activityLabel: UILabel = {
    let label = UILabel()
    
    label.text = "Activity"
    label.textColor = Color.darkText.value
    label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  private let addButton: UIButton = {
    let button = UIButton(type: .custom)
    
    button.setImage(UIImage(named: "addButton"), for: .normal)
    
    button.translatesAutoresizingMaskIntoConstraints = false
    
    return button
  }()
  
  private let activityTableView: UITableView = {
    let tableView = UITableView()
    
    tableView.backgroundColor = Color.lightBackground.value
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    return tableView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    translatesAutoresizingMaskIntoConstraints = false
    
    setupLayout()
  }
  
  private func setupLayout() {
    addSubview(activityLabel)
    addSubview(activityTableView)
    addSubview(addButton)
    
    NSLayoutConstraint.activate([
      activityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
      activityLabel.trailingAnchor.constraint(greaterThanOrEqualTo: addButton.leadingAnchor, constant: 8),
      activityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
      activityLabel.heightAnchor.constraint(equalToConstant: 36)
      ])
    
    NSLayoutConstraint.activate([
      addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
      addButton.topAnchor.constraint(equalTo: topAnchor, constant: 0),
      addButton.heightAnchor.constraint(equalTo: addButton.widthAnchor, multiplier: 1)
      ])
    
    NSLayoutConstraint.activate([
      activityTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      activityTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      activityTableView.topAnchor.constraint(equalTo: activityLabel.bottomAnchor, constant: 4),
      activityTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
      ])
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
