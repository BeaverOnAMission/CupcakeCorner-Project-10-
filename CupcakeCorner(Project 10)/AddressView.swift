//
//  AddressView.swift
//  CupcakeCorner(Project 10)
//
//  Created by mac on 14.04.2023.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    var body: some View {
        Form{
            Section{
                TextField("Name", text: $order.name)
                TextField("Address", text: $order.address)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            Section{
                NavigationLink{
                    CheckOutView(order: order)
                } label: {
                    Text("Check Out")
                }
            }
            .disabled(order.hasValidAddress == false)
        }.navigationTitle("Delievery details")
            .background(Color("Color"))
            .scrollContentBackground(.hidden)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order:Order())
    }
}
