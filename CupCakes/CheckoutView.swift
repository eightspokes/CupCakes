//
//  CheckoutView.swift
//  CupCakes
//
//  Created by Roman on 12/26/22.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var orderWrapper: OrderWrapper
    @State private var confirmationMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3){ image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                Text("Your total is \(orderWrapper.order.cost, format: .currency(code: "USD"))")
                Button("Place order",
                       action: {
                    Task{
                        await placeOrder()
                    }
                    
                })
                .padding()
            }
            
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingAlert){
            Button("Ok"){}
            
        } message: {
            Text(confirmationMessage)
        }
        
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(orderWrapper.order) else{
            print ("Failed to encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity) * \(Order.types[decodedOrder.type].lowercased()) cupcakes are on its way!"
            showingAlert = true
        }catch{
            print("Checkout failed")
            confirmationMessage = "Checkout failed"
            showingAlert = true
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(orderWrapper: OrderWrapper())
    }
}
