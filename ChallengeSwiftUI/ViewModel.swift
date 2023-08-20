//
//  ViewModel.swift
//  ChallengeSwiftUI
//
//  Created by Bravo Oporto, Edgar Dick Irwin on 20/08/23.
//

import SwiftUI

class ViewModel: ObservableObject {
    
    @Published var courses: [Course] = []
    func fetch() {
        guard let url = URL(string: "https://iosacademy.io/api/v1/courses/index.php") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data  = data , error == nil else {return}
            
            
            // Convert to JSON
            
            do {
                
                let courses = try JSONDecoder().decode([Course].self, from: data)
                
                DispatchQueue.main.async {
                    self.courses = courses
                }
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
