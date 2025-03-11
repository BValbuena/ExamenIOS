//
//  ProductDetailView.swift
//  examenIOS
//
//  Created by Admin on 11/3/25.
//

import SwiftUI

struct ProductDetailView: View {
    var product: Product
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: product.image)) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 300)
                .cornerRadius(15)
                
                Text(product.title)
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("\(product.price, specifier: "%.2f") €")
                    .font(.title2)
                    .foregroundColor(.green)
                    .bold()
                
                Text(product.description)
                    .font(.body)
                    .padding()
            }
            .padding()
        }
        .navigationTitle("Detalle")
    }
}
