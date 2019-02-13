//
//  Action.swift
//  BudgetUp
//
//  Created by Alex Fargo on 2/8/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import Foundation

enum ActionCategory: String {
  case invalid = "Category"
  case food
  case shopping
  case bills
  case entertainment
  case rent
  // rename to revenue? income? profit?
  case deposit
  case other
}

struct Action {
  var title: String = ""
  var description: String = ""
  var amount: Double = 0.00
  var date: NSDate = NSDate()
  var actionCetegory: String = ActionCategory.other.rawValue
  var actionCategoryEnum: ActionCategory {
    get {
      return ActionCategory(rawValue: actionCetegory)!
    }
    set {
      actionCetegory = newValue.rawValue
    }
  }
}
