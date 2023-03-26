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

enum DataLoadingState<Data> {
    case Idle
    case Loading
    case Successed(Data)
    case Failed(Error)
}

@MainActor
class ReposStore: ObservableObject {
    @Published private(set) var dataLoadingState: DataLoadingState<[Repo]> = .Idle
    
    func loadRepos(searchType: SearchType, searchQuery: String) async {
        dataLoadingState = .Loading
        
        switch searchType {
        case .Username:
            do {
                let res = try await GitHubApiClient.listRepositoriesForAUser(username: searchQuery)
                let data = Repos.fromApiResponseToModel(responseRepos: res)
                dataLoadingState = .Successed(data)
            } catch let error {
                print("Error on loadRepos: \(error)")
                dataLoadingState = .Failed(error)
            }
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
            Group {
                switch reposStore.dataLoadingState {
                case .Idle, .Loading:
                    ProgressView("Loading...")
                case .Successed(let repos):
                    VStack {
                        if repos.isEmpty {
                            Text("No repositories")
                                .fontWeight(.bold)
                        } else {
                            List(repos) { repo in
                                NavigationLink(destination: RepoDetailView(repo: repo)
                                    .navigationBarTitleDisplayMode(.inline)
                                ) {
                                    RepoRowView(repo: repo)
                                }
                            }
                            
                        }
                    }
                case .Failed(_):
                    VStack {
                        Group {
                            Image("GitHubMark")
                            Text("Failed to load repositories")
                                .padding(.top, 4)
                        }
                        .foregroundColor(.black)
                        .opacity(0.4)
                        
                        Button(action: {
                            Task {
                                await reposStore.loadRepos(searchType: searchType, searchQuery: searchQuery)
                            }
                        }) {
                            Text("Retry")
                                .fontWeight(.bold)
                        }
                        .padding(.top, 8)
                    }
                }
            }
            .navigationTitle("Repositories")
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
