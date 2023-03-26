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

class GetGitHubRepositoriesOfSpecificUserUseCase {
    let githubRepository = GitHubRepository()
    
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
            print("Error on GetGitHubRepositoriesOfSpecificUserUseCase: \(error)")
            throw error
        }
    }
}
