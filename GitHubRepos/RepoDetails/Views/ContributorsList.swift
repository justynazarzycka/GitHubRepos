//
//  ContributorsList.swift
//  GitHubRepos
//
//  Created by Justyna Zarzycka on 25/04/2021.
//

import SwiftUI
import URLImage

struct ContributorsList: View {
    var contributors: [RepoDetails.Contributor]
    
    var body: some View {
        VStack {
            
            Text("Contributors:")
                .font(.headline)
                .padding()
            
            ForEach(contributors) { contributor in
                HStack {
                    
                    URLImage(url: contributor.avatarURL,
                             inProgress: { progress in
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.gray)
                                    ProgressView()
                                }
                             },
                             failure: { error, retry in
                                Text("Failed to load avatar")
                             },
                             content: { image, info in
                                image
                                    .resizable()
                             })
                        .frame(width: 50, height: 50)
                    
                    Text(contributor.login)
                        .padding(.leading)
                    
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
            RepoDetails.Contributor(id: 1, login: "bieli", contributions: 4, avatarURL: URL( string: "https://avatars.githubusercontent.com/u/17747679?v=4")!),
            RepoDetails.Contributor(id: 2, login: "wolpear", contributions: 2, avatarURL: URL( string: "https://avatars.githubusercontent.com/u/17747679?v=4")!),
            RepoDetails.Contributor(id: 3, login: "janisz", contributions: 2, avatarURL: URL( string: "https://avatars.githubusercontent.com/u/17747679?v=4")!)
        ]
        
        ContributorsList(contributors: testData)
    }
}
