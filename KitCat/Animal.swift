//
//  Animal.swift
//  KitCat
//
//  Created by Anisha Pareek on 9/25/23.
//

import Foundation
import CoreML
import Vision

// structure to store result from the classification
struct Result: Identifiable {
    var id = UUID()
    
    var imageLabel: String
    var confidence: Double
}

class Animal: ObservableObject {
    
    // url for the image
    var imageUrl: String
    
    // image data
    var imageData: Data?
    
    // classified results
    var results: [Result]
    
    let modelFile = try! MobileNetV2(configuration: MLModelConfiguration())
    
    init() {
        self.imageUrl = ""
        self.imageData = nil
        self.results = []
    }
    
    init?(json: [String: Any]) {
        
        // check that JSON has a url
        guard let imageUrl = json["url"] as? String else {
            return nil
        }
        
        // set the animale properties
        self.imageUrl = imageUrl
        self.imageData = nil
        self.results = []
        
        Task {
            // download the image data
            await getImage()
        }
        
    }
    
    func getImage() async {
        
        // create a url object
        let url = URL(string: imageUrl)
        
        // check that url isn't nil
        if let url {
            do {
                // url session
                let (data, _) = try await URLSession.shared.data(from: url)
                self.imageData = data
                self.classifyAnimal()
            } catch {
                print(error.localizedDescription)
            }
        }

    }
    
    func classifyAnimal() {
        
        // Get a reference to the model
        // this is going to create the vision model for us to use
        let model = try! VNCoreMLModel(for: modelFile.model )
        
        // Create an image handler
        // This image handler will convert the image data into a format which the CoreML model can handle
        let handler = VNImageRequestHandler(data: imageData!)
        
        // Create a request to the model
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                print("Couldn't classify animals")
                return
            }
            
            // update the results
            // Go through each of the classification in the results
            for classification in results {
                var identifier = classification.identifier
                identifier = identifier.prefix(1).capitalized + identifier.dropFirst()
                self.results.append(Result(imageLabel: identifier, confidence: Double(classification.confidence)))
            }
        }
        
        // Execute the request
        do {
            try handler.perform([request])
        } catch {
            print("Invalid image")
        }
    }
}
