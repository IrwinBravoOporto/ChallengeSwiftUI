//
//  AsyncImageView.swift
//  ChallengeSwiftUI
//
//  Created by Bravo Oporto, Edgar Dick Irwin on 20/08/23.
//

import SwiftUI

struct AsyncImageView: View {
    @State private var imageData: Data?
    let urlString: String?
    
    var body: some View {
        if let data = imageData, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .onAppear {
                    if imageData == nil {
                        fetchData()
                    }
                }
        } else {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onAppear {
                    if imageData == nil {
                        fetchData()
                    }
                }
        }
    }
    
    private func fetchData() {
        guard let urlString = urlString, let url = URL(string: urlString) else {
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
