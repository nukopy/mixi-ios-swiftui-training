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
