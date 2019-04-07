//
//  Action.swift
//  BudgetUp
//
//  Created by Alex Fargo on 2/8/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import Foundation
import RealmSwift

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

class Action: Object {
  @objc dynamic var title: String = ""
  @objc dynamic var details: String = ""
  @objc dynamic var amount: Double = 0.00
  @objc dynamic var date: NSDate?
  @objc dynamic var actionCategory: String = ActionCategory.Other.rawValue
  var actionCategoryEnum: ActionCategory {
    get {
      return ActionCategory(rawValue: actionCategory)!
    }
    set {
      actionCategory = newValue.rawValue
    }
  }
}
