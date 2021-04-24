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
        static let baseURL = URL(string: "https://api.github.com/users/allegro")!
        
        // lists all repos for specified organization
        case repos
        
        var url: URL {
            switch self {
            case .repos:
                return EndPoint.baseURL.appendingPathComponent("/repos")
            }
        }
    }
    
    
    func getRepos() -> AnyPublisher<[Repo], Error> {
        request(for: EndPoint.repos)
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
