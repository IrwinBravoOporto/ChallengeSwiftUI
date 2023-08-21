import SwiftUI

struct ProductListView: View {
    @StateObject var productViewModel = ProductViewModel()
    
    var body: some View {
        NavigationView {
            List(productViewModel.products, id: \.self) { product in
                NavigationLink(destination: ProductDetailView(product: product)) {
                    HStack {
                        AsyncImageView(urlString: product.urlImagenes.first)
                            .frame(width: 130, height: 70)
                            .background(Color.gray)
                        
                        Text(product.nombre).bold()
                    }
                }
            }
            .navigationTitle("Productos")
            .onAppear {
                productViewModel.fetchProducts()
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        ProductListView()
    }
}
