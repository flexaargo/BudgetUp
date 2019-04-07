//
//  ViewController.swift
//  BudgetUp
//
//  Created by Alex Fargo on 2/4/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {
  let realm = try! Realm()
  
  var actions: Results<Action>?
  
  private let summaryView: SummaryView = SummaryView()
  private let activityView: ActivityView = ActivityView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "BudgetUp"
    
    view.addSubview(summaryView)
    view.addSubview(activityView)
    
    summaryView.setSummaryText(availableBalance: 200, budgetAmount: 200)
    
    activityView.addButton.addTarget(self, action: #selector(addButtonPressed), for: UIControl.Event.touchUpInside)
    
    activityView.activityTableView.delegate = self
    activityView.activityTableView.dataSource = self
    
    loadActivity()
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
  
  func save (action: Action) {
    do {
      try realm.write {
        realm.add(action)
      }
    } catch {
      print("Error saving the new action, \(error)")
    }
    
    activityView.activityTableView.reloadData()
  }
  
  func loadActivity () {
    actions = realm.objects(Action.self)
    
    activityView.activityTableView.reloadData()
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

}


extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return actions?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell", for: indexPath) as! ActionCell
    
    if let action = actions?[indexPath.row] {
      cell.action = action
    }
    
    return cell
  }
}

extension HomeViewController: AddActionDelegate {
  func addedAction(_ action: Action?) {
    // Animate the status bar back to white
    UIView.animate(withDuration: 0.4, animations: {
      self.navigationController?.navigationBar.barStyle = .black
    })
    
    // Check to see that action is not null
    guard let action = action else { return }
    
//    // Append the action to the list
//    actions.append(action)
    
    // Save the action
    self.save(action: action)
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
