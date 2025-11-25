import SwiftUI

struct AddItem: View {
    var expense: Expenses
    
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var type: String = "Personal"
    @State private var amount: Double = 0.0
    
    let types = ["Personal", "Business"]
    
    @State private var selectedCurrency: String = Locale.current.currency?.identifier ?? "USD"
    let currencies = Locale.commonISOCurrencyCodes.sorted()
    
    var body: some View {
        NavigationStack {
            List {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                HStack {
                    TextField("Enter Amount", value: $amount, format: .currency(code: selectedCurrency))
                        .keyboardType(.decimalPad)
                    
                    Picker("", selection: $selectedCurrency) {
                        ForEach(currencies, id: \.self) { code in
                            Text("\(currencyFlag(for: code)) \(code)")
                        }
                        
                    }
                    .labelsHidden()
                }
            }
            .navigationTitle("Add Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount, currency: selectedCurrency)
                    expense.items.append(item)
                    
                    name = ""
                    amount = 0.0
                    
                    dismiss()
                }
            }
        }
    }
    
    /// Important Code
    func flag(countryCode: String) -> String {
        countryCode
            .uppercased()
            .unicodeScalars
            .compactMap { UnicodeScalar(127397 + $0.value) }
            .map { String($0) }
            .joined()
    }
    
    func currencyFlag(for currencyCode: String) -> String {
        let locale = Locale.availableIdentifiers
            .compactMap { Locale(identifier: $0) }
            .first { $0.currency?.identifier == currencyCode }
        
        if let countryCode = locale?.region?.identifier {
            return flag(countryCode: countryCode)
        }
        
        return "💱"
    }
}

#Preview {
    AddItem(expense: Expenses())
}
