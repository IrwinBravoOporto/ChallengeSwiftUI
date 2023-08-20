//
//  ContentView.swift
//  ChallengeSwiftUI
//
//  Created by Bravo Oporto, Edgar Dick Irwin on 20/08/23.
//

import SwiftUI




struct Course: Hashable, Codable {
    let name: String
    let image: String
}

struct URLImage: View {
    let urlStrig: String
    
    @State var data: Data?
    
    var body: some View {
        if let data = data , let uiimage = UIImage(data: data){
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 70)
                .background(Color.gray)
        } else {
            Image(systemName: "video")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 130, height: 70)
                .background(Color.gray)
                .onAppear {
                    fetchData()
                }
        }
    }
    
    private func fetchData() {
        guard let url = URL(string: urlStrig) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        task.resume()
    }
}

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.courses, id: \.self) { course in
                    HStack {
                        URLImage(urlStrig: course.image)
                        Text(course.name).bold()
                    }.padding(3)
                    
                }
            }
            .navigationTitle("Elektra Digital")
            .onAppear {
                viewModel.fetch()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
