import SwiftUI

struct Practice: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(1..<101) {
                        Text("Hello Swift \($0)")
                    }
                }
                .padding()
            }
            .navigationTitle("Title")
            .navigationSubtitle("Hello Swift")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "applelogo")
                }

            }
            .toolbarTitleDisplayMode(.inlineLarge)
        }
    }
}

#Preview {
    Practice()
}
