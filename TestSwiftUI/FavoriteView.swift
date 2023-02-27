//
//  FavoriteView.swift
//  iDine
//
//  Created by Macbook Pro on 08/02/2023.
//

import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var favorite: Favorite
    
    var body: some View {
        
        NavigationStack {
            List {
                Section {
                    ForEach(favorite.items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price)")
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .navigationTitle("Favorite")
            .listStyle(.insetGrouped)
            .toolbar {
                EditButton()
            }
        }
        
    }
    
    func deleteItems(at offsets: IndexSet) {
        favorite.items.remove(atOffsets: offsets)
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
            .environmentObject(Favorite())
    }
}
