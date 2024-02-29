//
//  ContentView.swift
//  CupcakeCorner(Project 10)
//
//  Created by mac on 14.04.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    init() {
     UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
   }
    var body: some View {
        NavigationView{
                Form {
                    Section{
                        Picker("Select your cake type", selection: $order.type){
                            ForEach(Order.types.indices, id: \.self) {
                                Text(Order.types[$0])
                            }
                        }
                        Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 1...20)
                    }
                    Section{
                        Toggle("Special request", isOn: $order.specialRequestEnabled.animation())
                        
                        if order.specialRequestEnabled{
                            Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                            Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        }
                    }
                    Section{
                        NavigationLink{
                            AddressView(order:order)
                        } label: {
                            Text("Delievery details")
                        }
                    }
                }.background(Color("Color"))
                .scrollContentBackground(.hidden)
                .navigationTitle("Cupcake Corner")

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
