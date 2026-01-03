import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var showAddItem = false
    @State private var title = "iExpenses"
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.amount, order: .reverse)
    ]
    
    @State private var filterType = "All"
    
    var body: some View {
        NavigationStack {
            ExpenseView(sortOrder: sortOrder, filterType: filterType)
                .toolbar {
                    NavigationLink { AddItem() } label: {
                        Image(systemName: "plus")
                    }
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder.animation()) {
                            Text("Sort by amount")
                                .tag([ SortDescriptor(\ExpenseItem.amount, order: .reverse) ])
                            
                            Text("Sort by name")
                                .tag([ SortDescriptor(\ExpenseItem.name, order: .reverse) ])
                        }
                    }
                    
                    Menu("Type", systemImage: "return") {
                        Picker("Filter", selection: $filterType.animation()) {
                            Text("All")
                                .tag("All")
                            
                            Text("Personal")
                                .tag("Personal")
                            
                            Text("Business")
                                .tag("Business")
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

