//
//  RepoDetailsView.swift
//  GitHubRepos
//
//  Created by Justyna Zarzycka on 24/04/2021.
//

import SwiftUI

struct RepoDetailsView: View {
    var name: String
    @StateObject var repoDetailsVM = RepoDetailsViewModel()
    
    var body: some View {
        checkVMState(content: detalis, state: repoDetailsVM.state)
            .onAppear {
                repoDetailsVM.loadDetails(for: name)
            }

    }
    
    private var detalis: AnyView {
        guard let repo = repoDetailsVM.repoDetails else {
            return AnyView(Text("Something went worng"))
        }
        
        return AnyView(
            ScrollView {
                VStack {
                    Text(repo.name)
                        .font(.title)
                        .padding()
                    
                    RepoStatistics(stars: repo.stargazers, watchers: repo.watchers, forks: repo.forks)
                        .padding()
                    
                    
                    if let description = repo.description {
                        Text(description)
                            .padding()
                    }
                    
                    ContributorsList(contributors: repo.contributors)
                    
                    Spacer()
                }
            })
        
    }
}

struct RepoDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RepoDetailsView(name: "akubra")
    }
}

