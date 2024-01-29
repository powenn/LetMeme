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

func fetchMeme() async throws -> Data {
    let url = URL(string: "https://meme-api.com/gimme")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return data
}

func fetchMemeUrl(data:Data) async -> URL? {
    var memeUrl:URL? = nil
    do {
        let data = try await fetchMeme()
        let redditPost = try JSONDecoder().decode(RedditPost.self, from: data)
        memeUrl = redditPost.url
        print(memeUrl != nil ? "Fetched Url : \(memeUrl!)" : "Url Fetch failed")
    } catch {
        print("Error: \(error)")
    }
    return memeUrl
}

func fetcPostUrl(data:Data) async -> URL? {
    var postUrl:URL? = nil
    do {
        let data = try await fetchMeme()
        let redditPost = try JSONDecoder().decode(RedditPost.self, from: data)
        postUrl = redditPost.postLink
        print(postUrl != nil ? "Fetched Url : \(postUrl!)" : "Url Fetch failed")
    } catch {
        print("Error: \(error)")
    }
    return postUrl
}
