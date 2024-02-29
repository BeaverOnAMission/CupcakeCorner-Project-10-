//
//  CheckOutView.swift
//  CupcakeCorner(Project 10)
//
//  Created by mac on 14.04.2023.
//

import SwiftUI

struct CheckOutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showConfirmation = false
    @State private var errorMessage = ""
    @State private var showError = false
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale:3)
                { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 200)
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title).foregroundColor(.white)
                
                Button("Place order") {
                    Task{
                        await   placeOrder()
                    }
                }.padding()
                    .background(.white)
                    .clipShape(Capsule())
                    .padding()
            }.background(Color("Color"))
        }.navigationTitle("Check Out")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Tkank You",isPresented: $showConfirmation) {
                Button ("ok") {}
            } message: {
                    Text(confirmationMessage)
                }
            .alert("Oops!", isPresented: $showError) {
                Button("OK") { }
            } message: {
                Text(errorMessage)
            }
            
    }
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do{
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x\(Order.types[decodedOrder.type]) cupcakes is on its way"
            showConfirmation = true
        } catch {
            errorMessage = "Sorry, checkout failed.\n\nMessage: \(error.localizedDescription)"
            showError = true
        }
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(order:Order())
    }
}
