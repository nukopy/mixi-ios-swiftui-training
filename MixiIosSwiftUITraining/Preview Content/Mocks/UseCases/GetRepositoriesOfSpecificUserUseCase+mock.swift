//
//  GetRepositoriesOfSpecificUserUseCase+mock.swift
//  MixiIosSwiftUITraining
//
//  Created by nukopy on 2023/03/27
//

import Foundation

struct MockGetRepositoriesOfSpecificUserUseCase: GetGitHubRepositoriesOfSpecificUserUseCaseProtocol {
    private let repos: [Repo]
    private let error: Error?
    
    init(repos: [Repo], error: Error? = nil) {
        self.repos = repos
        self.error = error
    }
    
    func execute(searchType: SearchType, searchQuery: String) async throws -> [Repo] {
        if let error = error {
            throw error
        }
        
        return repos
    }
}
