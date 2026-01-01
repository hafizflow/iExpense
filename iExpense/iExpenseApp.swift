//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Hafizur Rahman on 25/11/25.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
