//
//  MainView.swift
//  examenIOS
//
//  Created by Admin on 11/3/25.
//

import SwiftUI

struct MainView: View {
    @State private var selectedCategory: String = "electronics"
    
    var body: some View {
        NavigationView {
            VStack {
                ProductGridView(category: selectedCategory)
                
                Menu("Seleccionar Categoría") {
                    Button("Electrónica") { selectedCategory = "electronics" }
                    Button("Joyería") { selectedCategory = "jewelery" }
                    Button("Hombre") { selectedCategory = "men's clothing" }
                    Button("Mujer") { selectedCategory = "women's clothing" }
                }
                .padding()
            }
            .navigationTitle("Tienda")
        }
    }
}

struct CategoryView: View {
    let category: String
    
    var body: some View {
        ProductGridView(category: category)
    }
}

struct ProductGridView: View {
    @StateObject var viewModel = ProductViewModel()
    let category: String
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack {
            SearchBar(text: $viewModel.searchText)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.filteredProducts) { product in
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            VStack(spacing: 8) {
                                AsyncImage(url: URL(string: product.image)) { image in
                                    image.resizable().scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(height: 150)
                                .frame(width: 50)
                                .clipped()
                                .cornerRadius(10)
                                
                                Text(product.title)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                                    .padding(.horizontal, 5)
                                    
                                Text("\(product.price, specifier: "%.2f") €")
                                    .font(.subheadline)
                                    .foregroundColor(.green)
                                    .bold()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(.white))
                            .cornerRadius(12)
                            .shadow(radius: 4)
                        }
                    }
                }
                .padding()
            }
            .onAppear {
                viewModel.fetchProducts(category: category)
            }
            .navigationTitle(category.capitalized)
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Buscar...", text: $text)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal)
    }
}
