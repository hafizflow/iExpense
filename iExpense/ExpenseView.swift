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
    
    let filterType: String
    
    init(
        sortOrder: [SortDescriptor<ExpenseItem>],
        filterType: String = "All"
    ) {
        self.filterType = filterType
        
        let predicate: Predicate<ExpenseItem>
        if filterType == "All" {
            predicate = #Predicate { _ in true }
        } else {
            predicate = #Predicate { item in
                item.type == filterType
            }
        }
        
        _expenses = Query(filter: predicate, sort: sortOrder)
    }
    
    var body: some View {
        List {
            ForEach(expenses) { item in
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
