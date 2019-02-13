//
//  ViewController.swift
//  BudgetUp
//
//  Created by Alex Fargo on 2/4/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  
  var actions: [Action] = [Action]()
  
  private let summaryView: SummaryView = SummaryView()
  private let activityView: ActivityView = ActivityView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initActionsWithDummyData()
    
    navigationItem.title = "BudgetUp"
    
    view.addSubview(summaryView)
    view.addSubview(activityView)
    
    summaryView.setSummaryText(availableBalance: 734.10, budgetAmount: 1000)
    
    activityView.addButton.addTarget(self, action: #selector(addButtonPressed), for: UIControl.Event.touchUpInside)
    
    activityView.activityTableView.delegate = self
    activityView.activityTableView.dataSource = self
  }
  
  @objc func addButtonPressed() {
    let addActivityViewController = AddActionViewController()
    
    addActivityViewController.modalTransitionStyle = .coverVertical
    addActivityViewController.modalPresentationStyle = .overCurrentContext
    
    addActivityViewController.addActionDelegate = self
    
    self.present(addActivityViewController, animated: true, completion: nil)
    
    UIView.animate(withDuration: 0.4, animations: {
      self.navigationController?.navigationBar.barStyle = .default
    })
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.barStyle = .black
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    setupLayout()
  }
  
  private func setupLayout() {
    
    guard let navigationController = navigationController else { return }
    
    NSLayoutConstraint.activate([
      summaryView.topAnchor.constraint(equalTo: navigationController.navigationBar.bottomAnchor, constant: 35),
      summaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      summaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      summaryView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -16)
      ])
    
    NSLayoutConstraint.activate([
      activityView.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 35),
      activityView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
      activityView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
      activityView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
      ])
  }
  
  private func initActionsWithDummyData() {
    var action = Action()
    action.title = "Lunch with friends"
    action.description = "Went to lunch with friends at In n Out"
    action.amount = -10.24
    action.actionCategoryEnum = .Food
    
    actions.append(action)
    
    var action2 = Action()
    action2.title = "Rent"
    action2.description = "Payed apartment rent"
    action2.amount = -650
    action2.actionCategoryEnum = .Rent
    
    actions.append(action2)
  }

}


extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return actions.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell", for: indexPath) as! ActionCell
    
    cell.action = actions[indexPath.row]
    
    return cell
  }
}

extension HomeViewController: AddActionDelegate {
  func addedAction(_ action: Action?) {
    UIView.animate(withDuration: 0.4, animations: {
      self.navigationController?.navigationBar.barStyle = .black
    })
    
    guard let action = action else { return }
    
    actions.append(action)
    
    activityView.activityTableView.reloadData()
  }
}

extension String {
  // formatting text for currency textField
  func currencyInputFormatting() -> String {
    var number: NSNumber!
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency                                         
    formatter.currencySymbol = formatter.locale.currencySymbol
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2
    
    var amountWithPrefix = self
    
    // remove from string: "$", ".", ","
    let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
    amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
    
    let double = (amountWithPrefix as NSString).doubleValue
    number = NSNumber(value: double / 100)
    
    // if first number is 0 or all numbers were deleted
    guard number != 0 as NSNumber else {
      return ""
    }
    
    return formatter.string(from: number)!
  }
}
