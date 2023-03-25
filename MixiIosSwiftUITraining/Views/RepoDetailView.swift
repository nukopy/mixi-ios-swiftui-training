//
//  RepoDetailView.swift
//  MixiIosSwiftUITraining
//
//  Created by nukopy on 2023/03/26
//

import SwiftUI

struct RepoDetailView: View {
    let repo: Repo
    
    var body: some View {
        ScrollView {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image("GitHubMark")
                            .resizable()
                            .frame(width: 16.0, height: 16.0)
                        
                        Text(repo.owner.name)
                            .font(.caption)
                    }
                    
                    Text(repo.name)
                        .font(.body)
                        .fontWeight(.bold)
                    Text(repo.description)
                        .padding(.top, 4)
                    
                    HStack {
                        Image(systemName: "star")
                        Text("\(repo.stargazersCount) stars")
                    }
                    .padding(.top, 8)
                    
                    Spacer()
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct RepoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RepoDetailView(repo: .mock1)
    }
}
