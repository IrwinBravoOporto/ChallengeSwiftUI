//
//  ProductDetailView.swift
//  ChallengeSwiftUI
//
//  Created by Bravo Oporto, Edgar Dick Irwin on 20/08/23.
//

import SwiftUI


struct ProductDetailView: View {
    let product: Producto
    @State private var imageData: Data?
    
    var body: some View {
        VStack {
            if let data = imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .onAppear {
                        fetchData()
                    }
            }
            
            // Espacio flexible para empujar los detalles hacia arriba
            Spacer().frame(height: 30)
            
            // Mostrar detalles del producto, como nombre, precio, etc.
            Text("Nombre: \(product.nombre)")
                .font(.title)
                .padding(.horizontal, 30) // Agrega un padding horizontal de 30 puntos al texto
            
            Spacer() // Espacio flexible para centrar el texto verticalmente
            
            // Puedes mostrar más detalles del producto aquí
        }
        .navigationBarTitle("Detalles del Producto", displayMode: .inline)
    }



    
    private func fetchData() {
        guard let urlString = product.urlImagenes.first, let url = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error loading image: \(error)")
                return
            }

            if let data = data {
                DispatchQueue.main.async {
                    imageData = data
                }
            }
        }
        task.resume()
    }
}
