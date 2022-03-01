//
//  CaseDetailWithNote.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 2/11/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import SwiftUI
struct CaseDetailWithNote: View {
    @Binding var imgName: String
    @Binding var caseNumber: String
    @Binding var imgTitle: String
    @Binding var imgDescription: String
    @State private var isEditingText = false
    
    
    var body: some View {
        HStack {
            VStack {
                HStack{
                    Spacer()
                    
                    Button(action: {
                        isEditingText.toggle()
                        
                    }, label:{
                        
                        HStack{
                            Text(imgTitle)
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .bold))
                                .padding(.top, 16)
                                .padding(.bottom, 5)
                                .truncationMode(.tail)
                                .lineLimit(1)
                            Spacer()
                            Image(systemName: "pencil")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(Color(red: 0.79, green: 0.74, blue: 1.00))
                                .padding(.top, 8)
                        }
                    })
                    Spacer()
                    
                }
                Text(imgDescription)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .light))
                    .padding(.trailing, 16)
                    .padding(.leading, 16)
                    .truncationMode(.tail)
                Spacer()
            }
            .frame(width: 180, height: 180)
            .cornerRadius(30)
            .background(
                RoundedRectangle(
                    cornerRadius: 20,
                    style: .continuous
                )
                .fill(Color(red: 0.11, green: 0.11, blue: 0.11))
            )
            
            VStack {
                AsyncImage(url: URL(string: imgName)){ phase in
                    switch phase {
                    case .empty:
                        VStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                        .frame(width: 180, height: 180)
                        .cornerRadius(30)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 20,
                                style: .continuous
                            )
                            .fill(Color(red: 0.11, green: 0.11, blue: 0.11))
                        )
                    case .success(let image):
                        VStack {
                            NavigationLink(
                                destination: SingleImage(imgName: $imgName, title: $imgTitle, description: $imgDescription)
                            ) {
                                
                                image.resizable()
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 180, height: 180)
                                    .clipped()
                                    .clipped()
                                    .background(
                                        RoundedRectangle(
                                            cornerRadius: 20,
                                            style: .continuous
                                        )
                                        .fill(Color(red: 0.11, green: 0.11, blue: 0.11))
                                    )
                            }
                        }
                        .frame(width: 180, height: 180)
                        .cornerRadius(30)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 20,
                                style: .continuous
                            )
                            .fill(Color(red: 0.11, green: 0.11, blue: 0.11))
                        )
 
                    case .failure:
                        VStack {
                            Image("caseImg")
                            Spacer()
                        }
                        .frame(width: 180, height: 180)
                        .cornerRadius(30)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 20,
                                style: .continuous
                            )
                            .fill(Color(red: 0.11, green: 0.11, blue: 0.11))
                        )
                    @unknown default:
                        Text("unknown").foregroundColor(.white)
                    }
                }
            }
        }        .sheet(isPresented: self.$isEditingText) {
            EditImgInfo(imgName: self.$imgName, caseNumber: self.$caseNumber, imgTitle: self.$imgTitle, imgDescription: self.$imgDescription )
        }
    }
}

struct CaseDetailWithNote_Previews: PreviewProvider {
    static var previews: some View {
        CaseDetailWithNote(imgName: .constant("testImg.png"), caseNumber: .constant("2468"), imgTitle: .constant("Untitled"), imgDescription: .constant("Lorem Ipsum"))
    }
}
