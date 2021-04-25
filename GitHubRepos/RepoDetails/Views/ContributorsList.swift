//
//  ContributorsList.swift
//  GitHubRepos
//
//  Created by Justyna Zarzycka on 25/04/2021.
//

import SwiftUI

struct ContributorsList: View {
    var contributors: [RepoDetails.Contributor]
    
    var body: some View {
        VStack {
            
            Text("Contributors:")
                .font(.headline)
                .padding()
            
            ForEach(contributors) { contributor in
                HStack {
                    Text(contributor.login)
                    
                    Spacer()
                    
                    VStack {
                        Text(String(contributor.contributions))
                        Text("contributions")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                }
                .padding(.leading)
                .padding(.trailing)
                Divider()
            }
        }
    }
}

struct ContributorsList_Previews: PreviewProvider {
    static var previews: some View {
        
        let testData = [
            RepoDetails.Contributor(id: 1, login: "bieli", contributions: 4),
            RepoDetails.Contributor(id: 2, login: "wolpear", contributions: 2),
            RepoDetails.Contributor(id: 3, login: "janisz", contributions: 2)
        ]
        
        ContributorsList(contributors: testData)
    }
}
