//
//  RepoListViewModel.swift
//  GitHubRepos
//
//  Created by Justyna Zarzycka on 24/04/2021.
//

import Foundation
import Combine

final class RepoListViewModel: ObservableObject {
    @Published var state = State.empty
    @Published var repos: [Repo] = []
    
    private var gitHubAPI = GitHubAPI()
    
    enum State {
        case empty
        case loading(Cancellable)
        case loaded
        case error(Error)
    }
    
    init() {
        loadRepos()
    }
}


extension RepoListViewModel {
    
    func loadRepos() {
        self.state = .loading(gitHubAPI.getRepos()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case let .failure(error):
                        self.state = .error(error)
                    }
                    
                },
                receiveValue: { value in
                    self.state = .loaded
                    self.repos = value
                }))
    }
}
