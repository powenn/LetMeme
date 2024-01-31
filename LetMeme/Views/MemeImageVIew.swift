//
//  MemeImageVIew.swift
//  LetMeme
//
//  Created by 蕭博文 on 2024/1/29.
//

import SwiftUI

struct MemeImageVIew:View {
    @Binding var postData:RedditPost?
    var body: some View {
        VStack {
            AsyncImage(url: postData?.url, transaction: Transaction(animation: .easeInOut)) { phase in
                switch phase {
                case .empty:
                    Color.gray.opacity(0.4)
                        .overlay(alignment: .center, content: {
                        ProgressView()
                    })
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 10)
                    
                case .failure(_):
                    Image(systemName: "questionmark.square")
                        .resizable()
                        .scaledToFit()
                    
                @unknown default:
                    Image(systemName: "questionmark.square")
                        .resizable()
                        .scaledToFit()
                }
            }
        }
    }
}

