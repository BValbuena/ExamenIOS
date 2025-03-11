//
//  ProductViewModel.swift
//  examenIOS
//
//  Created by Admin on 11/3/25.
//
import SwiftUI

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var searchText: String = ""
    
    func fetchProducts(category: String) {
        let urlString = "https://fakestoreapi.com/products/category/\(category)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.products = (try? JSONDecoder().decode([Product].self, from: data)) ?? []
                }
            }
        }.resume()
    }
    
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return products
        } else {
            return products.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
}
