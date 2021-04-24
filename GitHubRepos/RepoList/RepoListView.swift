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
            checkVMState(content: repoList, state: repoListVM.state)
                .navigationTitle("Allegro Repos")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var repoList: AnyView {
        AnyView(List {
            ForEach(repoListVM.repos) { repo in
                NavigationLink(destination: RepoDetailsView(name: repo.name)) {
                    Text(repo.name)
                }
            }
        })
    }
}


struct ReposList_Previews: PreviewProvider {
    static var previews: some View {
        RepoListView()
    }
}
