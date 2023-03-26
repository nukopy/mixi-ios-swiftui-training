//
//  User.swift
//  MixiIosSwiftUITraining
//
//  Created by nukopy on 2023/03/26
//

import Foundation

struct User: Equatable {
    let name: String
}

extension User {
    static func fromApiResponseToModel(responseUser: GitHubUser) -> User {
        return User(name: responseUser.login ?? "(no name)")
    }
}
