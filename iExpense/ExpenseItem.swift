//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Hafizur Rahman on 3/1/26.
//

import SwiftData
import SwiftUI

@Model
class ExpenseItem {
    var name: String
    var type: String
    var amount: Double
    var currency: String
    
    init(
        name: String,
        type: String,
        amount: Double,
        currency: String
    ) {
        self.name = name
        self.type = type
        self.amount = amount
        self.currency = currency
    }
}

