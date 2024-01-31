//
//  FetchMeme.swift
//  LetMeme
//
//  Created by 蕭博文 on 2024/1/29.
//

import Foundation

struct RedditPost: Decodable {
    let postLink: URL
    let subreddit: String
    let title: String
    let url: URL
    let nsfw: Bool
    let spoiler: Bool
    let author: String
    let ups: Int
    let preview: [URL]
}

func fetchMeme() async throws -> RedditPost {
    let url = URL(string: "https://meme-api.com/gimme")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let redditPost = try JSONDecoder().decode(RedditPost.self, from: data)
    print("Fetched post link : \(redditPost.postLink) , image url : \(redditPost.url)")
    return redditPost
}
