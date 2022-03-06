//
//  CameraView.swift
//  AVFoundation-Camera App
//
//  Created by Tarık Ateşer on 5.03.2022.
//

import Foundation
import AVFoundation
import SwiftUI

struct CameraView: UIViewControllerRepresentable{
    
    typealias UIViewControllerType = UIViewController;
    
    let camreaService: CameraService;
    let didFinishProccessingPhoto: (Result<AVCapturePhoto, Error>) -> ()
    
    func makeUIViewController(context: Context) -> UIViewController {
        
        camreaService.start(delegate: context.coordinator) { err in
            if let err = err {
                didFinishProccessingPhoto(.failure(err))
                return
            }
        }
        
        let viewController = UIViewController()
        viewController.view.backgroundColor = .black;
        viewController.view.layer.addSublayer(camreaService.previewLayer);
        camreaService.previewLayer.frame = viewController.view.bounds
        return viewController
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, didFinishProccessingPhoto: didFinishProccessingPhoto)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
    
    class Coordinator: NSObject, AVCapturePhotoCaptureDelegate{
        let parent: CameraView;
        private var didFinishProccessingPhoto: (Result<AVCapturePhoto, Error>) -> ();
        
        init(_ parent: CameraView, didFinishProccessingPhoto: @escaping (Result<AVCapturePhoto, Error>) -> () ) {
            self.parent = parent;
            self.didFinishProccessingPhoto = didFinishProccessingPhoto;
        }
        
        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            if let error = error {
                didFinishProccessingPhoto(.failure(error));
                return
            }
            didFinishProccessingPhoto(.success(photo));
        }
    }
}
