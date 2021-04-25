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
        case basicRepoDetails(_ name: String)
        case repoContributors(_ name: String)
        
        var url: URL {
            switch self {
            case .repos:
                return EndPoint.baseURL.appendingPathComponent("/users/allegro/repos")
            case .basicRepoDetails(let name):
                return EndPoint.baseURL.appendingPathComponent("/repos/allegro/\(name)")
            case .repoContributors(let name):
                return EndPoint.baseURL.appendingPathComponent("/repos/allegro/\(name)/contributors")
            }
        }
    }
    
    private func request<T: Decodable>(for endpoint: EndPoint) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: endpoint.url)
            .map { $0.data }
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    func getReposList() -> AnyPublisher<[Repo], Error> {
        request(for: EndPoint.repos)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    
    func getRepoDetails(for name: String) -> AnyPublisher<RepoDetails, Error> {
        getBasicRepoData(for: name)
            .flatMap(mergeRepo)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func mergeRepo(_ repo: RepoDetails.Basic) -> AnyPublisher<RepoDetails, Error> {
        getRepoContributors(for: repo.name)
            .map { contributors in
                RepoDetails(
                    id: repo.id,
                    name: repo.name,
                    description: repo.description,
                    stargazers: repo.stargazers,
                    watchers: repo.watchers,
                    forks: repo.forks,
                    contributors: contributors)
            }
            .eraseToAnyPublisher()
    }
    
    func getBasicRepoData(for name: String) -> AnyPublisher<RepoDetails.Basic, Error> {
        request(for: EndPoint.basicRepoDetails(name))
    }
    
    func getRepoContributors(for name: String) -> AnyPublisher<[RepoDetails.Contributor], Error> {
        request(for: EndPoint.repoContributors(name))
    }

}
