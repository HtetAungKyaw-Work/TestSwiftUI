//
//  CheckoutView.swift
//  TestSwiftUI
//
//  Created by Macbook Pro on 02/01/2023.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var order: Order
    @State private var paymentType = "Cash"
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var tipAmount = 15
    @State private var showPaymentAlert = false
    @State private var pickUpTime = "Now"
    
    let paymentTypes = ["Cash", "Credit Card", "iDine Points"]
    let tipAmounts = [10, 15, 20, 25, 0]
    let pickUpTimes = ["Now", "Tonight", "Tomorrow Morning"]
    
    var totalPrice: String  {
        let total = Double(order.total)
        let tipValue = total / 1000 * Double(tipAmount)
        return (total + tipValue).formatted(.currency(code: "USD"))
    }
    
    var body: some View {
        Form {
            Section {
                Picker("How do you want to pay?", selection: $paymentType) {
                    ForEach(paymentTypes, id: \.self) {
                        Text($0)
                    }
                }
                
                Toggle("Add iDine Loyalty Card", isOn: $addLoyaltyDetails.animation())
                
                if addLoyaltyDetails {
                    TextField("Enter your iDine ID", text: $loyaltyNumber)
                }
            }
            
            Section("Add  a tip?") {
                Picker("Percentage:", selection: $tipAmount) {
                    ForEach(tipAmounts, id: \.self) {
                        Text("\($0)%")
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Picker("When do you want to pick up?", selection: $pickUpTime) {
                ForEach(pickUpTimes, id: \.self) {
                    Text($0)
                }
            }
            
            Section("Total: \(totalPrice)") {
                Button("Confirm Order") {
                    showPaymentAlert.toggle()
                }
            }
        }
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Order confirmed", isPresented: $showPaymentAlert) {
            
        } message: {
            Text("Your total was \(totalPrice) - thank you")
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView().environmentObject(Order())
    }
}
