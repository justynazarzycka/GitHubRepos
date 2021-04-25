//
//  RepoDetailsViewModel.swift
//  GitHubRepos
//
//  Created by Justyna Zarzycka on 24/04/2021.
//

import Foundation
import Combine

final class RepoDetailsViewModel: ObservableObject {
    @Published var state = ViewModelState.empty
    @Published var repoDetails: RepoDetails?
    
    private var gitHubAPI = GitHubAPI()
}


extension RepoDetailsViewModel {
    func loadDetails(for name: String) {
        self.state = .loading(gitHubAPI.getRepoDetails(for: name).sink(
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
                                    self.repoDetails = value
                                }))
    }
}
