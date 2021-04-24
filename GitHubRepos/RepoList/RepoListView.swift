//
//  RepoListView.swift
//  GitHubRepos
//
//  Created by Justyna Zarzycka on 24/04/2021.
//

import SwiftUI

struct RepoListView: View {
    @StateObject var repoListVM = RepoListViewModel()
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle("Allegro Repos")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var content: some View {
        switch repoListVM.state {
        case .empty:
            return AnyView(EmptyView())
        case .loading:
            return AnyView(ProgressView())
        case .loaded:
            return AnyView(self.repoList)
        case let .error(error):
            return AnyView(Text(error.localizedDescription))
        }
    }
    
    private var repoList: some View {
        List {
            ForEach(repoListVM.repos) { repo in
                Text(repo.name)
            }
        }
    }
}


struct ReposList_Previews: PreviewProvider {
    static var previews: some View {
        RepoListView()
    }
}
