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
  let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("BudgetInfo.plist")
  
  var actions: Results<Action>?
  var budgetInfo: BudgetInfo?
  
  private let summaryView: SummaryView = SummaryView()
  private let activityView: ActivityView = ActivityView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "BudgetUp"
    
    view.addSubview(summaryView)
    view.addSubview(activityView)
    
    activityView.addButton.addTarget(self, action: #selector(addButtonPressed), for: UIControl.Event.touchUpInside)
    summaryView.editButton.addTarget(self, action: #selector(editBudgetButtonPressed), for: UIControl.Event.touchUpInside)
    
    activityView.activityTableView.delegate = self
    activityView.activityTableView.dataSource = self
    
    loadSummary()
    loadActivity()
  }
  
  @objc func editBudgetButtonPressed() {
    // Present the edit budget view controller
    let editBudgetViewController = EditBudgetViewController()
    
    editBudgetViewController.modalTransitionStyle = .coverVertical
    editBudgetViewController.modalPresentationStyle = .overCurrentContext
    
    editBudgetViewController.editBudgetDelegate = self
    
    editBudgetViewController.editView.budgetField.text = "$" + String(budgetInfo!.budget)
    editBudgetViewController.editView.budgetField.editingChanged()
    
    self.present(editBudgetViewController, animated: true, completion: nil)
    
    UIView.animate(withDuration: 0.4) {
      self.navigationController?.navigationBar.barStyle = .default
    }
  }
  
  @objc func addButtonPressed() {
    // Present the add action view controller
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
  
  func saveSummary() {
    let encoder = PropertyListEncoder()
    do {
      let data = try encoder.encode(self.budgetInfo)
      try data.write(to: self.dataFilePath!)
    } catch {
      print("Error encoding budget info, \(error)")
    }
    
    summaryView.setSummaryText(budgetInfo!)
  }
  
  func loadSummary() {
    if let data = try? Data(contentsOf: dataFilePath!) {
      let decoder = PropertyListDecoder()
      do {
        budgetInfo = try decoder.decode(BudgetInfo.self, from: data)
      } catch {
        print("Error decoding budget info, \(error)")
      }
    }
    
    if budgetInfo == nil {
      budgetInfo = BudgetInfo()
      budgetInfo?.budget = 250
      saveSummary()
    }
    
    summaryView.setSummaryText(budgetInfo!)
  }
  
  func deleteAction(at indexPath: IndexPath) {
    if let actionToDelete = self.actions?[indexPath.row] {
      do {
        try self.realm.write {
          // Change the remaining amount based on what action was deleted
          if actionToDelete.actionCategoryEnum == .Deposit {
            budgetInfo?.difference -= actionToDelete.amount
          } else {
            budgetInfo?.difference += actionToDelete.amount
          }
          
          saveSummary()
          
          self.realm.delete(actionToDelete)
        }
      } catch {
        print("Error deleting the action, \(error)")
      }
    }
  }
  
  private func setupLayout() {
    
    guard let navigationController = navigationController else { return }
    
    NSLayoutConstraint.activate([
      summaryView.topAnchor.constraint(equalTo: navigationController.navigationBar.bottomAnchor, constant: 24),
      summaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      summaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      summaryView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -16)
      ])
    
    NSLayoutConstraint.activate([
      activityView.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 24),
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
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      deleteAction(at: indexPath)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
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
    
    // Save the action
    self.save(action: action)
    
    // Change the remaining amount in the budget and save the summary
    if action.actionCategoryEnum == .Deposit {
      budgetInfo?.difference += action.amount
    } else {
      budgetInfo?.difference -= action.amount
    }
    
    saveSummary()
  }
}

extension HomeViewController: EditBudgetDelegate {
  func newBudget(budgetAmount: Int) {
    budgetInfo?.budget = budgetAmount
    
    saveSummary()
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
