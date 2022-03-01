//
//  CaseAudioRecording.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 2/25/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import SwiftUI

struct CaseAudioRecording: View {
    
    @Binding var voiceMemo: String!
    @Binding var voiceMemoTitle: String!
    @Binding var localAudioFile: URL!
    
    @ObservedObject var audioPlayer = AudioPlayer()
    @State var duration = 3.6
    
    var body: some View {
        HStack{
            Text(voiceMemoTitle)
                .padding(10)
                .foregroundColor(.white)
                .font(.system(size: 24, weight: .bold))
                .truncationMode(.tail)
            
//            
            Text("\(Double(duration).removeZerosFromEnd()) seconds")
                    .padding(10)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .light))
                    .truncationMode(.tail)
            
            
            Spacer()
            if audioPlayer.isPlaying == false {
                Button(action: {
                    self.audioPlayer.startPlayback(audio: localAudioFile, test: voiceMemo)
                }) {
                    Image(systemName: "play.circle")
                        .imageScale(.large)
                        .padding(.trailing, 20)
                }
            } else {
                Button(action: {
                    self.audioPlayer.stopPlayback()
                }) {
                    Image(systemName: "stop.fill")
                        .imageScale(.large)
                        .padding(.trailing, 20)
                }
            }
            
            
            
        }
        .frame(width: 370, height: 100)
        .cornerRadius(30)
        .background(
            RoundedRectangle(
                cornerRadius: 20,
                style: .continuous
            )
            .fill(Color(red: 0.11, green: 0.11, blue: 0.11))
        )
        .task {
             audioPlayer.getDuration(url: voiceMemo)
        }
    }
}

struct CaseAudioRecording_Previews: PreviewProvider {
    static var previews: some View {
        CaseAudioRecording(voiceMemo: .constant("http://google.com"), voiceMemoTitle: .constant("HEHE"), localAudioFile: .constant(URL(string: "google.com")))
    }
}
