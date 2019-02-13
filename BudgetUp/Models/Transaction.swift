//
//  Transaction.swift
//  BudgetUp
//
//  Created by Alex Fargo on 2/8/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import Foundation

enum TransactionCategory: String {
  case food
  case shopping
  case bills
  case entertainment
  case rent
  // rename to revenue? income? profit?
  case deposit
  case other
}

struct Transaction {
  var title: String = ""
  var description: String = ""
  var amount: Double = 0.00
  var date: NSDate = NSDate()
  var transactionCategory: String = TransactionCategory.other.rawValue
  var transactionCategoryEnum: TransactionCategory {
    get {
      return TransactionCategory(rawValue: transactionCategory)!
    }
    set {
      transactionCategory = newValue.rawValue
    }
  }
}
