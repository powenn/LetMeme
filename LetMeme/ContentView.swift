//
//  ContentView.swift
//  LetMeme
//
//  Created by 蕭博文 on 2024/1/29.
//

import SwiftUI
import ColorfulX


struct ContentView: View {
    @State var imageUrl:URL? = nil
    @State var postUrl:URL? = nil
    @State var colors: [Color] = ColorfulPreset.lemon.colors
    
    var body: some View {
        ZStack {
            ColorfulView(color: $colors)
                .ignoresSafeArea()
            VStack {
                Spacer()
                MemeImageVIew(imageUrl: $imageUrl)
                    .aspectRatio(0.9, contentMode: .fit)
                Spacer()
                Link(destination: postUrl ?? URL(string: "https://www.apple.com")!, label: {
                    Text("View reddit post")
                }).disabled(postUrl == nil)
                Button("Get Meme", action: {
                    Task {
                        imageUrl = nil
                        postUrl = nil
                        let data = try await fetchMeme()
                        imageUrl = await fetchMemeUrl(data: data)
                        postUrl  = await fetcPostUrl(data: data)
                    }
                }).buttonStyle(GrowingButton())
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
