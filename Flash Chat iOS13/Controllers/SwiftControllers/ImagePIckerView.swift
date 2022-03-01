//
//  ImagePIckerView.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 2/6/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import FirebaseStorage

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Binding var label: String?
    @Binding var caseNumber: String
    @Binding var sourceType: UIImagePickerController.SourceType
    
    @Environment(\.presentationMode) var isPresented
        
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        imagePicker.delegate = context.coordinator // confirming the delegate
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }

    // Connecting the Coordinator class with this struct
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: ImagePickerView
    
    init(picker: ImagePickerView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let storage = Storage.storage().reference()
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        guard let imageData = selectedImage.pngData() else {return}
        let filename = "case:" + self.picker.caseNumber + "file:" + String(Float.random(in: 1..<100)) + ".png"
        
        storage.child("images/" + filename).putData(
            imageData,
            metadata: nil,
            completion: { _, error in
                guard error == nil else {
                    print("-------------------------failed to upload-------------------------")
                    return
                }
                storage.child("images/" + filename).downloadURL { url, err in
                    guard let url = url, error == nil else { return }
                    let urlString = url.absoluteString
                    FirebaseManager.shared.firestore
                        .collection("cases")
                        .document(self.picker.caseNumber)
                        .collection("images")
                        .document(filename)
                        .setData(["imgName": urlString])
                    print("DownloadURL: \(urlString)")
                    return
                    
                }
        })
        picker.dismiss(animated: true, completion: nil)
    }
}
