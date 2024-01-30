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
    
    @State var hasAppeared:Bool = false
    
    private func GetMeme(){
        Task{
            imageUrl = nil
            postUrl = nil
            let data = try await fetchMeme()
            imageUrl = await fetchMemeUrl(data: data)
            postUrl  = await fetcPostUrl(data: data)
        }
    }
    
    var body: some View {
        ZStack {
            ColorfulView(color: $colors)
                .opacity(0.55)
                .ignoresSafeArea()
            VStack {
                Spacer()
                MemeImageVIew(imageUrl: $imageUrl)
                    .aspectRatio(0.9, contentMode: .fit)
                    .onTapGesture {
                        if (postUrl != nil) {
                            let vc = SFSafariViewController(url: postUrl!)
                            UIApplication.shared.firstKeyWindow?.rootViewController?.present(vc, animated: true)
                        }
                    }
                Spacer()
                Button("Get Meme", action: {
                    Task {
                        GetMeme()
                    }
                }).buttonStyle(GrowingButton())
            }
            .padding()
        }.onReceive(timer, perform: { _ in
            colors = ColorfulPreset.allCases.randomElement()!.colors
        }).onAppear(perform: {
            if !hasAppeared {
                GetMeme()
                hasAppeared = true
            }
        })
    }
}

#Preview {
    ContentView()
}
