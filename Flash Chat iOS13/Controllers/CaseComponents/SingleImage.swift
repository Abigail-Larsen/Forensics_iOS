//
//  SingleImage.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 2/17/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import SwiftUI

struct SingleImage: View {
    @Binding var imgName: String
    @Binding var title: String
    @Binding var description: String
    var body: some View {
        VStack{
            
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 32, weight: .bold))
                .padding(.bottom, 15)
            AsyncImage(url: URL(string: imgName)){ phase in
                switch phase {
                case .empty:
                    VStack {
                        ProgressView()
                            .padding(50)
                            .frame(width: UIScreen.main.bounds.size.width)
                    }
                case .success(let image):
                    VStack {
                        image.resizable()
                            .scaledToFit()
                    }

                case .failure:
                    VStack {
                        Image("caseImg").resizable()
                            .scaledToFit()
                        Text("FAILED")
                    }
                @unknown default:
                    Text("unknown").foregroundColor(.white)
                }
            }
            
            ScrollView{
                Text(description)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .light))
                    .padding(.top, 15)
            }
            Spacer()
        }
        .background(.black)
    }
}

struct SingleImage_Previews: PreviewProvider {
    static var previews: some View {
        SingleImage(imgName: .constant("caseImg") , title: .constant("testImg title"), description: .constant("description"))
    }
}
