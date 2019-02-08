//
//  ViewController.swift
//  BudgetUp
//
//  Created by Alex Fargo on 2/4/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  
  private let summaryView: SummaryView = SummaryView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupLayout()
    
    summaryView.setSummaryText(availableBalance: 734.10, budgetAmount: 1000)
  }
  
  private func setupLayout() {
    view.addSubview(summaryView)
    
    NSLayoutConstraint.activate([
      summaryView.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
      summaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      summaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      summaryView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -16)
      ])
  }

}

