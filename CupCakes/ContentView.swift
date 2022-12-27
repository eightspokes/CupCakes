//
//  ContentView.swift
//  CupCakes
//
//  Created by Roman on 12/21/22.
//

import SwiftUI




struct ContentView: View {
    @StateObject var orderWrapper = OrderWrapper()
    
    var body: some View {
        
        NavigationView{
            Form {
                Section{
                    Picker("Select your cake type", selection: $orderWrapper.order.type){
                        ForEach(Order.types.indices){
                            Text(Order.types[$0])
                        }
                    }
                    Text("Order chosen: \(Order.types[orderWrapper.order.type])")
                    Stepper("Number of cakes: \(orderWrapper.order.quantity)", value: $orderWrapper.order.quantity, in: 1...20)
                }
                
                Section{
                    Toggle("Any special request?", isOn: $orderWrapper.order.specialRequestEnabled.animation())
                    
                    if orderWrapper.order.specialRequestEnabled{
                        Toggle("Add extra frosting", isOn: $orderWrapper.order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $orderWrapper.order.addSprinkles)
                        
                    }
                }
                Section{
                    NavigationLink{
                        AddressView(orderWrapper: orderWrapper)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
