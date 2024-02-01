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
    @State var colors: [Color] = ColorfulPreset.allCases.randomElement()!.colors
    
    @State var postData:RedditPost? = nil
    @State var showWebView = false
    @State var hasAppeared:Bool = false
    
    let timer = Timer.publish(every: 8, on: .main, in: .common).autoconnect()
    
    func getMeme(){
        Task{
            postData = nil
            postData = try await fetchMeme()
        }
    }
    
    var body: some View {
        ZStack {
            ColorfulView(color: $colors)
                .opacity(0.55)
                .ignoresSafeArea()
            VStack {
                Spacer()
                MemeImageVIew(postData: $postData)
                    .aspectRatio(0.9, contentMode: .fit)
                    .onTapGesture {
                        if (postData?.postLink != nil) {
                            let vc = SFSafariViewController(url: postData!.postLink)
                            UIApplication.shared.firstKeyWindow?.rootViewController?.present(vc, animated: true)
                        }
                    }
                Spacer()
                Button("Get Meme", action: {
                    getMeme()
                }).buttonStyle(GrowingButton())
            }
            .padding()
        }.onReceive(timer, perform: { _ in
            colors = ColorfulPreset.allCases.randomElement()!.colors
        }).onAppear(perform: {
            if !hasAppeared {
                getMeme()
                hasAppeared = true
            }
        })
    }
}

#Preview {
    ContentView()
}
