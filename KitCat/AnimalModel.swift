//
//  AnimalModel.swift
//  KitCat
//
//  Created by Anisha Pareek on 9/25/23.
//

import Foundation
import SwiftUI

class AnimalModel: ObservableObject {
    @Published var animal = Animal()
    
    func getAnimal() async {

        let stringUrl = Bool.random() ? catUrl : dogUrl
        
        // Create a url object
        let url = URL(string: stringUrl)
        
        // Check that the url isn't nil
        if let url {
            
            do {
                // url session
                let (data, _) = try await URLSession.shared.data(from: url)
                
                // Attempt to parse json into an array of dictionaries
                if let json = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
                    let item = json.isEmpty ? [:] : json[0]
                    if let animal = Animal(json: item) {
                        await MainActor.run {
                            while animal.results.isEmpty {}
                            self.animal = animal
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }

    }
}
