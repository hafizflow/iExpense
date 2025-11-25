//
//  AddItem.swift
//  iExpense
//
//  Created by Hafizur Rahman on 25/11/25.
//

import SwiftUI

struct AddItem: View {
    var expense: Expenses
    
    @State private var name: String = ""
    @State private var type: String = "Personal"
    @State private var amount: Double = 0.0
    
    let types = ["Personal", "Business"]
    
    var body: some View {
        NavigationStack {
            List {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Enter Amount", value: $amount, format: .currency(code: "usd"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expense.items.append(item)
                    
                    name = ""
                    amount = 0.0
                }
            }
        }
    }
}

#Preview {
    AddItem(expense: Expenses())
}
