//
//  User.swift
//  MixiIosSwiftUITraining
//
//  Created by nukopy on 2023/03/26
//

import Foundation

struct User {
    let name: String
}

extension User {
    static func fromApiResponseToModel(responseUser: GitHubUser) -> User {
        return User(name: responseUser.login ?? "(no name)")
    }
}
