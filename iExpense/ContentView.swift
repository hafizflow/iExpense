import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    let currency: String
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decoded = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decoded
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
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
                
                ForEach(expenses.items.filter { item in
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
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("iExpenses")
            .toolbar {
                Button("Add") {
                    showAddItem = true
                }
            }
            .sheet(isPresented: $showAddItem) {
                AddItem(expense: expenses)
            }
        }
    }
    
    func deleteItems(offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
