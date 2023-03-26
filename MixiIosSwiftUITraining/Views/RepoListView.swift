//
//  RepoListView.swift
//  MixiIosSwiftUITraining
//
//  Created by nukopy on 2023/03/24
//

import SwiftUI
import CoreData

enum SearchType {
    case Username
    case Organization
}

@MainActor
class ReposStore: ObservableObject {
    
    @Published private(set) var repos = [Repo]()
    
    func loadRepos(searchType: SearchType, searchQuery: String) async {
        switch searchType {
        case .Username:
            let res = await GitHubApiClient.listRepositoriesForAUser(username: searchQuery)
            self.repos = Repos.fromApiResponseToModel(responseRepos: res)
        case .Organization:
            // NOP
            // TODO: GitHub Organization 検索用のメソッドを API クライアントに実装する
            break
        }
    }
}

struct RepoListView: View {
    @StateObject private var reposStore = ReposStore()
    
    @State private var searchType: SearchType = .Username
    @State private var searchQuery: String = "nukopy"
    
    var body: some View {
        NavigationView {
            if reposStore.repos.isEmpty {
                ProgressView("Loading...")
            } else {
                List(reposStore.repos) { repo in
                    NavigationLink(destination: RepoDetailView(repo: repo)
                        .navigationBarTitleDisplayMode(.inline)
                    ) {
                        RepoRowView(repo: repo)
                    }
                }
                .navigationTitle("Repositories")
            }
        }
        .task {
            await reposStore.loadRepos(searchType: searchType, searchQuery: searchQuery)
        }
    }
}

struct RepoListView_Previews: PreviewProvider {
    static var previews: some View {
        RepoListView()
    }
}
