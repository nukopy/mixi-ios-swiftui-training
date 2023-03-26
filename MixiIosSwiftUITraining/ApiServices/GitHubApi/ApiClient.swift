//
//  GitHubApi.swift
//  MixiIosSwiftUITraining
//
//  Created by nukopy on 2023/03/26
//

import Foundation

protocol ApiClientProtocol {}

class GitHubApiClient: ApiClientProtocol {
    typealias cli = HttpClient
    
    static func listRepositoriesForAUser(username: String, perPage: Int = 50, page: Int = 1) async throws -> ResponseListRepositoriesForAUser {
        // doc: https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#list-repositories-for-a-user
        let url = "https://api.github.com/users/\(username)/repos"
        let headers = [
            "Accept": "application/json",
//            "Accept: application/vnd.github+json"
            "X-GitHub-Api-Version": "2022-11-28"
        ]
        let queryParams = [
            "sort": "updated", // 更新順
            "direction": "desc", // 降順
            // TODO: ページングの実装
            "per_page": "\(perPage)",
            "page": "\(page)"
        ]
        
        do {
            let response = try await cli.get(url: url, headers: headers, queryParams: queryParams) as ResponseListRepositoriesForAUser
            
            return response
        } catch let error {
            print("Error on GET request to \(url): \(error)")
            throw error
        }
    }
}
