//
//  AnimalRow.swift
//  KitCat
//
//  Created by Anisha Pareek on 9/26/23.
//

import SwiftUI

struct AnimalRow: View {
    var imageLabel: String
    var confidence: Double
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            VStack {
                HStack {
                    Text(imageLabel)
                    Spacer()
                    Text(String(format: "%.2f%%", confidence * 100))
                }
                .bold()
                ProgressBar(value: confidence)
                    .frame(height: 10)
            }
            .padding(10)
        }
    }
}

struct AnimalRow_Previews: PreviewProvider {
    static var previews: some View {
        AnimalRow(imageLabel: "Husky", confidence: 0.23)
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
