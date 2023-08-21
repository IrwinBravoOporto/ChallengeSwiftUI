//
//  ViewModel.swift
//  ChallengeSwiftUI
//
//  Created by Bravo Oporto, Edgar Dick Irwin on 20/08/23.
//

import SwiftUI

class ProductViewModel: ObservableObject {
    @Published var products: [Producto] = []
    
    func fetchProducts() {
        guard let url = URL(string: "http://alb-dev-ekt-875108740.us-east-1.elb.amazonaws.com/sapp/productos/plp/1/ad2fdd4bbaec4d15aa610a884f02c91a") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let responseData = try JSONDecoder().decode(ResponseData.self, from: data)
                DispatchQueue.main.async {
                    self.products = responseData.resultado.productos
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

