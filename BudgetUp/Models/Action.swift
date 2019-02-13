//
//  Action.swift
//  BudgetUp
//
//  Created by Alex Fargo on 2/8/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import Foundation

enum ActionCategory: String, CaseIterable {
  case Food
  case Shopping
  case Bills
  case Entertainment
  case Rent
  // rename to revenue? income? profit?
  case Deposit
  case Other
}

struct Action {
  var title: String = ""
  var details: String = ""
  var amount: Double = 0.00
  var date: NSDate?
  var actionCategory: String = ActionCategory.Other.rawValue
  var actionCategoryEnum: ActionCategory {
    get {
      return ActionCategory(rawValue: actionCategory)!
    }
    set {
      actionCategory = newValue.rawValue
    }
  }
}
