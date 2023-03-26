//
//  ResponseTypes.swift
//  MixiIosSwiftUITraining
//
//  Created by nukopy on 2023/03/26
//

import Foundation

// MARK: GET /users/{username}/repos
// doc: https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#list-repositories-for-a-user
typealias ResponseListRepositoriesForAUser = [GitHubRepositoryModel]
