//
//  Transaction.swift
//  BudgetUp
//
//  Created by Alex Fargo on 2/8/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import Foundation

enum TransactionType {
  case food
  case shopping
  case bills
  case entertainment
  case rent
  case deposit
}

struct Transaction {
  var title: String
  var description: String?
  var amount: Double
  var transactionType: TransactionType
}
