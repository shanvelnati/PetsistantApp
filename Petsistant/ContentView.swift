//
//  ContentView.swift
//  Petsistant
//
//  Created by Shantanu Velnati on 1/28/24.
//

import SwiftUI

struct ContentView: View {
    @State private var currentQuote = "Tap the lion to get a motivational quote! 🚀"
    @State private var isJumping = false
    var body: some View {
    ZStack{
        Color.black.edgesIgnoringSafeArea(.all)
        VStack {
            Text("🦁")
                .font(.system(size: 100))
                .offset(y: isJumping ? -20 : 0)
                .onTapGesture {
                    withAnimation { self.isJumping = true}
                    DispatchQueue.main.async {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                            withAnimation {
                                self.isJumping = false
                            }
                        }
                    }
                    
                }
                                    
            Text(currentQuote)
                .font(.headline)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
        }
        
        }
    }
}

#Preview {
    ContentView()
}
