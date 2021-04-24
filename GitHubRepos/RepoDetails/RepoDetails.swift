//
//  RepoDetails.swift
//  GitHubRepos
//
//  Created by Justyna Zarzycka on 24/04/2021.
//

import Foundation

struct RepoDetails: Codable {
    var id: Int
    var name: String
    
    // not every repo has a description
    var description: String?
    var stargazers: Int
    var watchers: Int
    var forks: Int
    
    enum CodingKeys: String, CodingKey {
        case stargazers = "stargazers_count"
        case id, name, description, watchers, forks
    }
}
