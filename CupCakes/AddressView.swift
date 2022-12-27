//
//  AddressView.swift
//  CupCakes
//
//  Created by Roman on 12/26/22.
//

import SwiftUI

struct AddressView: View {
    // You must gime me an order in orderd to use this view
    @ObservedObject var orderWrapper : OrderWrapper
    
    var body: some View {
        
            Form{
                Section{
                    TextField("Name", text: $orderWrapper.order.name)
                    TextField("Street address", text: $orderWrapper.order.streetAddress)
                    TextField("City", text: $orderWrapper.order.city )
                    TextField("Zip", text: $orderWrapper.order.zip)
                }
                Section{
                    NavigationLink{
                        CheckoutView(orderWrapper: orderWrapper)
                    }label: {
                        Text("Checkout ")
                            
                    }
                }.disabled(orderWrapper.order.hasValidAddress == false)
                
            }
            .navigationTitle("Delivery details")
            .navigationBarTitleDisplayMode(.inline)
    }
}
struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddressView(orderWrapper: OrderWrapper())
        }
        
    }
}
