//
//  CaseDetailsUI.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 1/3/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseStorage

enum ActiveSheet: Identifiable {
    case AR, photo, photoLibrary, voiceRecorder
    
    var id: Int {
        hashValue
    }
}

struct CaseDetailsUI: View {
    @Binding var caseNumber: String
    
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var selectedImage: UIImage?
    @State private var label: String?
    @State private var isImagePickerDisplay = false
    @State private var isScanDisplay = false
    @State var activeSheet: ActiveSheet?
    
    @ObservedObject var caseGetter = CaseGetter()
    
    
    
    var body: some View {
                VStack{
                    HStack {
                        Spacer()
                        Text(caseNumber).foregroundColor(.white).font(.system(size: 24))
                        Spacer()
                    }
                    
                    ScrollView {
                        VStack{
                            ForEach(caseGetter.caseScans) { item in
                                CaseScanItem(caseNumber: self.$caseNumber, date: .constant(item.date), scanName: .constant(item.scanName))
                            }

                            ForEach(caseGetter.caseAudios) { item in
                                CaseAudioRecording(voiceMemo: .constant(item.voiceMemo), voiceMemoTitle: .constant(item.voiceMemoTitle ?? "voice memo title"), localAudioFile: .constant(item.localAudioFile))
                            }
                            ForEach(caseGetter.caseImgs) { item in
                                CaseDetailWithNote(imgName: .constant(item.imgName), caseNumber: self.$caseNumber, imgTitle: .constant(item.imgTitle ?? "Untitled Img"), imgDescription: .constant(item.imgDescription ?? "Please add an image description."))
                            }
                            Spacer()
                        }
                    }
                    HStack {
                        Spacer()

                        Menu {
                            Button(action: {
                                self.activeSheet = .voiceRecorder
                            }){
                                Label("Add Memo", systemImage: "waveform")
                            }
                            Button(action: {
                                self.activeSheet = .photoLibrary
                                self.sourceType = .photoLibrary
                                self.isImagePickerDisplay.toggle()
                            }){
                                Label("Upload Photo", systemImage: "photo.on.rectangle.angled")
                            }
                            Button(action: {
                                self.activeSheet = .photo
                                self.sourceType = .camera
                                self.isImagePickerDisplay.toggle()
                            }){
                                Label("Take Photo", systemImage: "camera.fill")
                            }
                            Button(action: {
                                self.activeSheet = .AR
                                self.isScanDisplay.toggle()
                            }){
                                Label("Add Scan", systemImage: "skew")
                            }
                        } label: {
                            Label("Add", systemImage: "plus.circle")
                                .foregroundColor(Color(red: 0.79, green: 0.74, blue: 1.00))
                                .padding(15)
                        }
                    }
                
                .navigationTitle("")
                .padding(20)
            }
                .background(.black)
                .navigationTitle("")
                .navigationBarHidden(false)
        .sheet(item: $activeSheet) { item in
                    switch item {
                    case .AR:
                        ScanningViewController(caseNumber: self.$caseNumber)
                    case .photo:
                        ImagePickerView(selectedImage: self.$selectedImage, label: self.$label, caseNumber: self.$caseNumber, sourceType: self.$sourceType)
                    case .photoLibrary:
                        ImagePickerView(selectedImage: self.$selectedImage, label: self.$label, caseNumber: self.$caseNumber, sourceType: self.$sourceType)
                    case .voiceRecorder:
                        AudioRecordingView(audioRecorder: AudioRecorder(), caseNumber: self.$caseNumber)
                    }
                }
        .onAppear {
            caseGetter.fetchItems(caseNumber: caseNumber)
            caseGetter.fetchAudioItems(caseNumber: caseNumber)
            caseGetter.fetchScans(caseNumber: caseNumber)
        }
    }
}

struct CaseDetailsUI_Previews: PreviewProvider {
    static var previews: some View {
        CaseDetailsUI(caseNumber: .constant("123"))
.previewInterfaceOrientation(.portrait)
    }
}

extension ForEach where Data.Element: Hashable, ID == Data.Element, Content: View {
    init(values: Data, content: @escaping (Data.Element) -> Content) {
        self.init(values, id: \.self, content: content)
    }
}
