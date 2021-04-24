//
//  RepoStatistics.swift
//  GitHubRepos
//
//  Created by Justyna Zarzycka on 24/04/2021.
//

import SwiftUI

struct RepoStatistics: View {
    var stars: Int
    var watchers: Int
    var forks: Int
    
    var body: some View {
        HStack {
            Property(imageName: "star.fill", number: stars)
            
            Spacer()
            
            Property(imageName: "eye", number: watchers)
            
            Spacer()
            
            Property(imageName: "tuningfork", number: forks)
        }
        .padding()
    }
    
    private struct Property: View {
        var imageName: String
        var number: Int
        
        var body: some View {
            VStack(alignment: .center) {
                Text(String(number))
                
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
            }
        }
    }
}

struct RepoStatistics_Previews: PreviewProvider {
    static var previews: some View {
        RepoStatistics(stars: 34, watchers: 42, forks: 9283)
    }
}
