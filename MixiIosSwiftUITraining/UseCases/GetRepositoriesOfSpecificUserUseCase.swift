//
//  GetGitHubRepositoriesOfSpecificUserUseCase.swift
//  MixiIosSwiftUITraining
//
//  Created by nukopy on 2023/03/26
//

import Foundation

enum SearchTypeError: Error {
    case unknownSearchType
}

protocol GetGitHubRepositoriesOfSpecificUserUseCaseProtocol {
    func execute(searchType: SearchType, searchQuery: String) async throws -> [Repo]
}

struct GetGitHubRepositoriesOfSpecificUserUseCase: GetGitHubRepositoriesOfSpecificUserUseCaseProtocol {
    private let githubRepository: GitHubRepositoryProtocol
    
    // Dependency Injection（GitHubRepository の I/F を抽象化した protocol をイニシャライザの引数とする）
    init(githubRepository: GitHubRepositoryProtocol = GitHubRepository()) {
        self.githubRepository = githubRepository
    }
    
    func execute(searchType: SearchType, searchQuery: String) async throws -> [Repo] {
        do {
            switch searchType {
            case .Username:
                let data = try await githubRepository.getRepositoriesOfSpecificUser(searchQuery: searchQuery)
                return data
            case .Organization:
                // NOP
                // TODO: GitHub Organization 検索用のメソッドを API クライアントに実装する
                throw SearchTypeError.unknownSearchType
            }
        } catch let error {
            throw error
        }
    }
}
