//
//  RepoListView.swift
//  MixiIosSwiftUITraining
//
//  Created by nukopy on 2023/03/24
//

import SwiftUI
import CoreData

struct RepoListView: View {
    @StateObject private var viewModel = RepoListViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.dataLoadingState {
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
                                await viewModel.onRetryButtonTapped()
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
            await viewModel.onAppear()
        }
    }
}

struct RepoListView_Previews: PreviewProvider {
    static var previews: some View {
        RepoListView()
    }
}
