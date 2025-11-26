//import SwiftUI
//
//struct EditItem: View {
//    var expense: Expenses
//    var item: ExpenseItem
//    
//    @Environment(\.dismiss) var dismiss
//    
//    @State private var name: String
//    @State private var type: String
//    @State private var amount: Double
//    @State private var currency: String
//    
//    let types = ["Personal", "Business"]
//    
//    init(expense: Expenses, item: ExpenseItem) {
//        self.expense = expense
//        self.item = item
//        
//        _name = State(initialValue: item.name)
//        _type = State(initialValue: item.type)
//        _amount = State(initialValue: item.amount)
//        _currency = State(initialValue: item.currency)
//    }
//    
//    var body: some View {
//        NavigationStack {
//            Form {
//                TextField("Name", text: $name)
//                
//                Picker("Type", selection: $type) {
//                    ForEach(types, id: \.self) { Text($0) }
//                }
//                
//                TextField("Amount", value: $amount, format: .number)
//                    .keyboardType(.decimalPad)
//            }
//            .navigationTitle("Edit Item")
//            .toolbar {
//                Button("Save") {
//                    saveChanges()
//                }
//            }
//        }
//    }
//    
//    func saveChanges() {
//        if let index = expense.items.firstIndex(where: { $0.id == item.id }) {
//            expense.items[index] = ExpenseItem(
//                id: item.id,
//                name: name,
//                type: type,
//                amount: amount,
//                currency: currency
//            )
//        }
//        dismiss()
//    }
//}
