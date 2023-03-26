//
//  Repo.swift
//  MixiIosSwiftUITraining
//
//  Created by nukopy on 2023/03/26
//

import Foundation

struct Repo: Identifiable {
    let id: Int
    let name: String
    let owner: User
    let description: String
    let stargazersCount: Int
}

typealias Repos = [Repo]

extension Repos {
    static func fromApiResponseToModel(responseRepos: ResponseListRepositoriesForAUser) -> [Repo] {
        // API レスポンスからモデルへ詰め替える処理
        return responseRepos.map { resRepo in
            let user = User.fromApiResponseToModel(responseUser: resRepo.owner)
            
            return Repo(
                id: resRepo.id,
                name: resRepo.fullName!,
                owner: user,
                description: resRepo.repositoryDescription ?? "",
                stargazersCount: resRepo.stargazersCount!
            )
        }
    }
}
