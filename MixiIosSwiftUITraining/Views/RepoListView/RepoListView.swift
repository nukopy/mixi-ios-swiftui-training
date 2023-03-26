//
//  RepoListView.swift
//  MixiIosSwiftUITraining
//
//  Created by nukopy on 2023/03/24
//

import SwiftUI
import CoreData

struct RepoListView: View {
    @StateObject private var viewModel: RepoListViewModel
    
    init(viewModel: RepoListViewModel) {
        // Cannot assign to property: 'viewModel' is a get-only property
        // @StateObject で annotate された property は get-only の制約が課されてしまうため、イニシャライザ引数による DI ができない
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
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
        let mockRepos: [Repo] = [.mock1, .mock2, .mock3, .mock4, .mock5]
        
        // mock usecases
        let successedUsecase = MockGetRepositoriesOfSpecificUserUseCase(repos: mockRepos)
        let emptyUsecase = MockGetRepositoriesOfSpecificUserUseCase(repos: [Repo]())
        let failedUsecase = MockGetRepositoriesOfSpecificUserUseCase(repos: [Repo](), error: DummyError())
        
        Group {
            RepoListView(viewModel: RepoListViewModel(usecase: successedUsecase))
                .previewDisplayName("Success: 5 Repositories got")
            RepoListView(viewModel: RepoListViewModel(usecase: emptyUsecase))
                .previewDisplayName("Success: Repositories is empty ")
            RepoListView(viewModel: RepoListViewModel(usecase: failedUsecase))
                .previewDisplayName("Failed: Error occurred when getting repositories")
        }
    }
}
