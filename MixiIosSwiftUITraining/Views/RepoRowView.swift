//
//  RepoRowView.swift
//  MixiIosSwiftUITraining
//
//  Created by nukopy on 2023/03/26
//

import SwiftUI

struct RepoRowView: View {
    let repo: Repo
    
    var body: some View {
        HStack {
            Image("GitHubMark")
                .resizable()
                .frame(width: 44.0, height: 44.0)
            VStack(alignment: .leading) {
                Text(repo.owner.name)
                    .font(.caption)
                
                Text(repo.name)
                    .font(.body)
                    .fontWeight(.semibold)
                
            }
        }
    }
}

struct RepoRowView_Previews: PreviewProvider {
    static var previews: some View {
        RepoRowView(repo: .mock1)
    }
}
