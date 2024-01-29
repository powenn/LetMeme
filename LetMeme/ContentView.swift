//
//  ContentView.swift
//  LetMeme
//
//  Created by 蕭博文 on 2024/1/29.
//

import SwiftUI
import ColorfulX
import SafariServices

struct ContentView: View {
    @State var imageUrl:URL? = nil
    @State var postUrl:URL? = nil
    @State var colors: [Color] = ColorfulPreset.allCases.randomElement()!.colors
    
    let timer = Timer.publish(every: 8, on: .main, in: .common).autoconnect()
    @State private var showWebView = false
    
    var body: some View {
        ZStack {
            ColorfulView(color: $colors)
                .opacity(0.55)
                .ignoresSafeArea()
            VStack {
                Spacer()
                MemeImageVIew(imageUrl: $imageUrl)
                    .aspectRatio(0.9, contentMode: .fit)
                Spacer()
                Button(action: {
                    let vc = SFSafariViewController(url: postUrl ?? URL(string: "https://www.apple.com")!)
                    
                    UIApplication.shared.firstKeyWindow?.rootViewController?.present(vc, animated: true)
                }, label: {
                    Text("View post")
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
        }.onReceive(timer, perform: { _ in
            colors = ColorfulPreset.allCases.randomElement()!.colors
        })
    }
}

#Preview {
    ContentView()
}
