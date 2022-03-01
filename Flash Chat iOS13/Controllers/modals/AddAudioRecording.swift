//
//  AudioRecordingView.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 2/25/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import SwiftUI

struct AudioRecordingView: View {
    @ObservedObject var audioRecorder: AudioRecorder
    @Binding var caseNumber: String
    @State private var newDescription = ""
    @State private var newTitle = ""

    @State var startTimer = false
    @State var counter = 0.0
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            
            VStack(alignment: .leading){
                Text("New Voice Memo before recording").foregroundColor(.white).font(.system(size: 18, weight: .bold))
            }
            
            TextField("Voice Memo Title", text: $newTitle )
                .foregroundColor(.white)
                .textFieldStyle(OvalTextFieldStyle())
                .padding(.top, 10)
            
            
            Spacer()
            HStack{
                Text("\(Double(counter).removeZerosFromEnd())")
                    .onReceive(timer) { input in
                        if startTimer {
                            counter += 0.2
                        }
                    }
                    .foregroundColor(.white)
                    .font(.system(size: 64))
                
            }
            Spacer()
            
            if audioRecorder.recording == false {
                Button(action: {
                    startTimer = true
                    self.audioRecorder.startRecording()
                }) {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipped()
                        .foregroundColor(.red)
                        .padding(.bottom, 40)
                }
            } else {
                Button(action: {
                    startTimer = false
                    self.audioRecorder.stopRecording(caseNumber: caseNumber, audioTitle: newTitle) }) {
                    Image(systemName: "stop.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipped()
                        .foregroundColor(.red)
                        .padding(.bottom, 40)
                }
            }
        }
        .padding(50)
    }
       
}

struct AudioRecordingView_Previews: PreviewProvider {
    static var previews: some View {
        AudioRecordingView(audioRecorder: AudioRecorder(), caseNumber: .constant("2468"))
            .preferredColorScheme(.dark)
    }
}

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 1
//        formatter.maximumFractionDigits = (self.components(separatedBy: ".").last)!.count
        return String(formatter.string(from: number) ?? "")
    }
}
