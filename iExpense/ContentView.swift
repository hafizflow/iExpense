import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var showAddItem = false
    @State private var title = "iExpenses"
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.amount, order: .reverse)
    ]
    
    var body: some View {
        NavigationStack {
            ExpenseView(sortOrder: sortOrder)
                .toolbar {
                    NavigationLink { AddItem() } label: {
                        Text("Add")
                    }
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder.animation()) {
                            Text("Sort by amount")
                                .tag([ SortDescriptor(\ExpenseItem.name) ])
                            
                            Text("Sort by amount")
                                .tag([ SortDescriptor(\ExpenseItem.amount) ])
                        }
                    }
                }
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ExpenseItem.self)
}

