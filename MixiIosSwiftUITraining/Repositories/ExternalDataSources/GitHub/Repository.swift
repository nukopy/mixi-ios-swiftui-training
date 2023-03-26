//
//  Repository.swift
//  MixiIosSwiftUITraining
//
//  Created by nukopy on 2023/03/26
//

import Foundation

protocol GitHubRepositoryProtocol { // GitHub のリポジトリではなく、Repository パターンのリポジトリだよ
    func getRepositoriesOfSpecificUser(searchQuery username: String) async throws -> [Repo]
}

class GitHubRepository: GitHubRepositoryProtocol {
    func getRepositoriesOfSpecificUser(searchQuery username: String) async throws -> [Repo] {
        // 外部データソースからのデータの取得
        let res = try await GitHubApiClient.fetchListRepositoriesForAUser(username: username)
        
        // 外部データソースからドメインモデルへの詰め替え
        let data = Repos.fromApiResponseToModel(responseRepos: res)
        
        return data
    }
}
