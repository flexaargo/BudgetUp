//
//  ViewController.swift
//  BudgetUp
//
//  Created by Alex Fargo on 2/4/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  
  var transactions: [Transaction] = [Transaction]()
  
  private let summaryView: SummaryView = SummaryView()
  private let activityView: ActivityView = ActivityView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initTransactionsWithDummyData()
    
    navigationItem.title = "BudgetUp"
    
    view.addSubview(summaryView)
    view.addSubview(activityView)
    
    summaryView.setSummaryText(availableBalance: 734.10, budgetAmount: 1000)
    
    activityView.activityTableView.delegate = self
    activityView.activityTableView.dataSource = self
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    setupLayout()
  }
  
  private func setupLayout() {
    
    guard let navigationController = navigationController else { return }
    
    NSLayoutConstraint.activate([
      summaryView.topAnchor.constraint(equalTo: navigationController.navigationBar.bottomAnchor, constant: 45),
      summaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      summaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      summaryView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -16)
      ])
    
    NSLayoutConstraint.activate([
      activityView.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 36),
      activityView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
      activityView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
      activityView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
      ])
  }
  
  private func initTransactionsWithDummyData() {
    
  }

}


extension HomeViewController: UITableViewDelegate {
  
}

extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionCell
    
    return cell
  }
  
  
}
