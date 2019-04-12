//
//  EditBudgetViewController.swift
//  BudgetUp
//
//  Created by Alex Fargo on 4/11/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

protocol EditBudgetDelegate {
  func newBudget(budgetAmount: Int)
}

class EditBudgetViewController: UIViewController {
  
  var editBudgetDelegate: EditBudgetDelegate?
  
  let standaloneNavigationItem: UINavigationItem = {
    let navigationItem = UINavigationItem()
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))
    navigationItem.rightBarButtonItem?.tintColor = Color.affirmation.value
    
    return navigationItem
  }()
  
  lazy var navigationBar: UINavigationBar = {
    let navigationBar = UINavigationBar()
    
    navigationBar.isTranslucent = false
    navigationBar.delegate = self
    navigationBar.backgroundColor = .white
    navigationBar.items = [standaloneNavigationItem]
    
    navigationBar.translatesAutoresizingMaskIntoConstraints = false
    
    return navigationBar
  }()
  
  let editView = EditBudgetView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = Color.lightBackground.value
    
    view.addSubview(navigationBar)
    view.addSubview(editView)
    
    setupLayout()
  }
  
  @objc func doneButtonPressed() {
    self.editBudgetDelegate?.newBudget(budgetAmount: editView.budgetField.integerValue)
    dismissKeyboard()
    dismiss(animated: true, completion: nil)
  }
  
  func setupLayout() {
    NSLayoutConstraint.activate([
      navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
      navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
      navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
      ])
    
    NSLayoutConstraint.activate([
      editView.leftAnchor.constraint(equalTo: view.leftAnchor),
      editView.rightAnchor.constraint(equalTo: view.rightAnchor),
      editView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
      editView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
  }
  
}

extension EditBudgetViewController: UINavigationBarDelegate {
  func position(for bar: UIBarPositioning) -> UIBarPosition {
    return .topAttached
  }
}
