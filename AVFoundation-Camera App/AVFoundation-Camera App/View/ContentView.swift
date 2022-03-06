//
//  ContentView.swift
//  AVFoundation-Camera App
//
//  Created by Tarık Ateşer on 5.03.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var capturedImage: UIImage? = nil;
    @State private var isCustomCameraViewPresented = false;
    
    var body: some View {
        ZStack{
            if capturedImage != nil {
                Image(uiImage: capturedImage!)
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
            }else{
                Color(UIColor.systemBackground)
            }
            
            VStack{
                Spacer();
                Button(action: {isCustomCameraViewPresented.toggle()}, label: {
                    Image(systemName: "camera.fill")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                })
                    .padding(.bottom)
                    .sheet(isPresented: $isCustomCameraViewPresented, content:{
                        CustomCameraView(capturedImage: $capturedImage)
                    })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
