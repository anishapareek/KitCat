//
//  ContentView.swift
//  KitCat
//
//  Created by Anisha Pareek on 9/25/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model: AnimalModel
    
    var body: some View {
        VStack {
                GeometryReader { geometry in
                    Image(uiImage: UIImage(data: model.animal.imageData ?? Data()) ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .edgesIgnoringSafeArea(.all)
                }
                
                HStack {
                    Text("What is it?")
                        .font(.title)
                        .bold()
                    
                    Spacer()
                    
                    Button {
                        Task {
                            await self.model.getAnimal()
                        }
                    } label: {
                        Text("Next")
                            .bold()
                    }
                    .disabled(model.animal.imageData == nil ? true : false)
                }
                .padding(.horizontal)
                .padding(.top, -40)
                
                
                List(model.animal.results) { result in
                    AnimalRow(imageLabel: result.imageLabel, confidence: result.confidence)
                        .padding(5)
                        .listRowSeparator(.hidden)
                    
                }
                .padding(.horizontal, -10)
                .listStyle(.plain)
            
        }
        .onAppear {
            Task {
                await model.getAnimal()
            }
        }
        .opacity(model.animal.imageData == nil ? 0 : 1)
        .animation(.easeIn, value: 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: AnimalModel())
    }
}
