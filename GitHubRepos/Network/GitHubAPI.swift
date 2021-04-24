//
//  GitHubAPI.swift
//  GitHubRepos
//
//  Created by Justyna Zarzycka on 24/04/2021.
//

import Foundation
import Combine

struct GitHubAPI {
    
    private let decoder = JSONDecoder()
    
    
    // API endpoints.
    private enum EndPoint {
        static let baseURL = URL(string: "https://api.github.com")!
        
        // lists all repos for specified organization
        case repos
        case repoDetails(_ name: String)
        
        var url: URL {
            switch self {
            case .repos:
                return EndPoint.baseURL.appendingPathComponent("/users/allegro/repos")
            case .repoDetails(let name):
                return EndPoint.baseURL.appendingPathComponent("/repos/allegro/\(name)")
            }
        }
    }
    
    
    func getRepos() -> AnyPublisher<[Repo], Error> {
        request(for: EndPoint.repos)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    
    func getRepoDetails(for name: String) -> AnyPublisher<RepoDetails, Error> {
        request(for: EndPoint.repoDetails(name))
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
 
    private func request<T: Decodable>(for endpoint: EndPoint) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: endpoint.url)
            .map { $0.data }
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
