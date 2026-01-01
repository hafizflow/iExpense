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

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]
    @State private var showAddItem = false
    
    func amountColor(for amount: Double) -> Color {
        switch amount {
            case ..<20:
                return .green
            case ..<50:
                return .orange
            case ..<100:
                return .blue
            default:
                return .red
        }
    }
    
    @State private var expenseType: String = "All"
    let expenseTypes: [String] = ["All", "Personal", "Business"]
    @State private var title = "iExpenses"
    
    
    var body: some View {
        NavigationStack {
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
                            .foregroundStyle(amountColor(for: item.amount))
                    }
                }
                .onDelete(perform: deleteItem)
                
            }
            .toolbar {
                NavigationLink(destination: AddItem()) {
                    Text("Add")
                }
            }
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func deleteItem(offSet: IndexSet) {
        for index in offSet {
            modelContext.delete(expenses[index])
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ExpenseItem.self)
}

