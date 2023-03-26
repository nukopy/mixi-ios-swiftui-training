//
//  RepoListViewModel.swift
//  MixiIosSwiftUITraining
//
//  Created by nukopy on 2023/03/26
//

import Foundation

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

protocol RepoListViewModelProtocol {
    func onAppear() async
    func onRetryButtonTapped() async
}

@MainActor
class RepoListViewModel: ObservableObject, RepoListViewModelProtocol {
    @Published private(set) var dataLoadingState: DataLoadingState<[Repo]> = .Idle
    @Published public var searchType: SearchType = .Username
    @Published public var searchQuery: String = "nukopy"
    
    private let usecase = GetGitHubRepositoriesOfSpecificUserUseCase()
    
    func onAppear() async {
        dataLoadingState = .Loading
        do {
            let repos = try await usecase.execute(searchType: searchType, searchQuery: searchQuery)
            dataLoadingState = .Successed(repos)
        } catch let error {
            print("Error: \(error)")
            dataLoadingState = .Failed(error)
        }
    }
    
    func onRetryButtonTapped() async {
        dataLoadingState = .Loading
        do {
            let repos = try await usecase.execute(searchType: searchType, searchQuery: searchQuery)
            dataLoadingState = .Successed(repos)
        } catch let error {
            dataLoadingState = .Failed(error)
        }
    }
}
