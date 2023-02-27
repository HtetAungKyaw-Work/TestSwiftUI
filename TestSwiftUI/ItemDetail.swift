//
//  ItemDetail.swift
//  TestSwiftUI
//
//  Created by Macbook Pro on 02/01/2023.
//

import SwiftUI

struct ItemDetail: View {
    @EnvironmentObject var order: Order
    @EnvironmentObject var favorite: Favorite
    let item: MenuItem
    
    @State private var isPressed = false
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(item.mainImage)
                    .resizable()
                    .scaledToFit()
                
                Text("Photo: \(item.photoCredit)")
                    .padding(4)
                    .background(.black)
                    .font(.caption)
                    .foregroundColor(.white)
                    .offset(x: -5, y: -5)
            }
            Text(item.description)
                .padding()
            
            Button("Order This") {
                order.add(item: item)
            }
            .buttonStyle(.borderedProminent)
                
            Spacer()
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                self.isPressed.toggle()
                if (isPressed == true) {
                    favorite.add(item: item)
                }
                else {
                    favorite.remove(item: item)
                }
            } label: {
                Image(systemName: !isPressed ? "heart" : "heart.fill")
                    .tint(.black)
            }
        }
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ItemDetail(item: MenuItem.example).environmentObject(Order())
                .environmentObject(Favorite())
        }
    }
}
