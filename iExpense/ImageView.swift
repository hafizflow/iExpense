    //
    //  ImageView.swift
    //  iExpense
    //
    //  Created by Hafizur Rahman on 26/11/25.
    //

import SwiftUI

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

struct ImageView: View {
    @State private var dragamount = CGSize.zero
    
    var body: some View {
        VStack {
            Button("Tap") {
                let input = """
    {
        "name": "Taylor Swift",
        "address": {
            "street": "555, Taylor Swift Avenue",
            "city": "Nashville"
        }
    }
    """
                
                let data = Data(input.utf8)
                let decode = JSONDecoder()
                
                if let user = try? decode.decode(User.self, from: data) {
                    print(user.address.city)
                }
            }
            .buttonStyle(.borderedProminent)
            
            Image("apple")
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal) { size, axis in
                    size * 0.8
                }
                .clipShape(.rect(cornerRadius: 8))
                .offset(dragamount)
                .gesture (
                    DragGesture()
                        .onChanged { dragamount = $0.translation }
                        .onEnded { _ in
                            withAnimation {
                                dragamount = .zero
                            }
                        }
                )
        }
    }
}

#Preview {
    ImageView()
}
