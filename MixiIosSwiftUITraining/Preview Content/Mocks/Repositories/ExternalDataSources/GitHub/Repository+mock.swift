//
//  Repository+mock.swift
//  MixiIosSwiftUITraining
//
//  Created by nukopy on 2023/03/27
//

import Foundation

struct MockGitHubRepository: GitHubRepositoryProtocol {
    let repos: [Repo]
    let error: Error?
    
    // イニシャライザ引数で返り値となる Array<Repo> を受け取る
    init(repos: [Repo], error: Error? = nil) {
        self.repos = repos
        self.error = error
    }
    
    // getRepositoriesOfSpecificUser でイニシャライザ引数で受け取った値をそのまま返す。
    // 本来は GitHub API へアクセスする部分をモックしている
    func getRepositoriesOfSpecificUser(searchQuery username: String) async throws -> [Repo] {
        // エラーのモック
        if let error = error {
            throw error
        }
        
        return repos
    }
}
