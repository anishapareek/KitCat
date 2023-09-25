//
//  Animal.swift
//  KitCat
//
//  Created by Anisha Pareek on 9/25/23.
//

import Foundation

class Animal {
    
    // url for the image
    var imageUrl: String
    
    // image data
    var imageData: Data?
    
    init() {
        self.imageUrl = ""
        self.imageData = nil
    }
    
    init?(json: [String: Any]) {
        
        // check that JSON has a url
        guard let imageUrl = json["url"] as? String else {
            return nil
        }
        
        // set the animale properties
        self.imageUrl = imageUrl
        self.imageData = nil
        
        // download the image data
        getImage()
        
    }
    
    func getImage() {
        
    }
}
