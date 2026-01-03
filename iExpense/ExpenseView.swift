//
//  ExpenseView.swift
//  iExpense
//
//  Created by Hafizur Rahman on 3/1/26.
//

import SwiftData
import SwiftUI

struct ExpenseView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]
    
    @State private var expenseType: String = "All"
    let expenseTypes: [String] = ["All", "Personal", "Business"]
    
    init(sortOrder: [SortDescriptor<ExpenseItem>]) {
        _expenses = Query(sort: sortOrder)
    }
    
    var body: some View {
        List {
            Picker("", selection: $expenseType.animation()) {
                ForEach(expenseTypes, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            
            ForEach(expenses.filter { item in
                expenseType == "All" || item.type == expenseType
            }) { item in
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text(item.name).font(.headline)
                        Text(item.type)
                    }
                    
                    Spacer()
                    Text(item.amount, format: .currency(code: item.currency))
                        .font(.headline)
                }
            }
            .onDelete(perform: deleteItem)
            
        }
    }
    
    func deleteItem(offSet: IndexSet) {
        for index in offSet {
            modelContext.delete(expenses[index])
        }
    }
}

#Preview {
    ExpenseView(sortOrder: [SortDescriptor(\ExpenseItem.amount)])
}
