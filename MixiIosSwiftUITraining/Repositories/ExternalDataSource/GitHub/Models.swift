//
//  Models.swift
//  MixiIosSwiftUITraining
//
//  Created by nukopy on 2023/03/26
//

import Foundation

// MARK: - Model - GitHub plan
// ref: https://github.com/nerdishbynature/octokit.swift/blob/main/OctoKit/Plan.swift#L7:12
struct Plan: Decodable {
    let name: String?
    let space: Int?
    let numberOfCollaborators: Int?
    let numberOfPrivateRepos: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case space
        case numberOfCollaborators = "collaborators"
        case numberOfPrivateRepos = "private_repos"
    }
}

// MARK: - Model - GitHub user
// ref: https://github.com/nerdishbynature/octokit.swift/blob/main/OctoKit/User.swift#L9:12
struct GitHubUser: Decodable {
    let id: Int
    let login: String? // GitHub のユーザ ID (e.g. "nukopy")
    let avatarURL: String?
    let gravatarID: String?
    let type: String?
    let name: String?
    let company: String?
    let blog: String?
    let location: String?
    let email: String?
    let numberOfPublicRepos: Int?
    let numberOfPublicGists: Int?
    let numberOfPrivateRepos: Int?
    let nodeID: String?
    let url: String?
    let htmlURL: String?
    let followersURL: String?
    let followingURL: String?
    let gistsURL: String?
    let starredURL: String?
    let subscriptionsURL: String?
    let reposURL: String?
    let eventsURL: String?
    let receivedEventsURL: String?
    let siteAdmin: Bool?
    let hireable: Bool?
    let bio: String?
    let twitterUsername: String?
    let numberOfFollowers: Int?
    let numberOfFollowing: Int?
    let createdAt: String?
    let updatedAt: String?
    let numberOfPrivateGists: Int?
    let numberOfOwnPrivateRepos: Int?
    let amountDiskUsage: Int?
    let numberOfCollaborators: Int?
    let twoFactorAuthenticationEnabled: Bool?
    let subscriptionPlan: Plan?

    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarURL
        case gravatarID
        case type
        case name
        case company
        case blog
        case location
        case email
        case numberOfPublicRepos = "public_repos"
        case numberOfPublicGists = "public_gists"
        case numberOfPrivateRepos = "total_private_repos"
        case nodeID
        case url
        case htmlURL
        case followersURL
        case followingURL
        case gistsURL
        case starredURL
        case subscriptionsURL
        case reposURL
        case eventsURL
        case receivedEventsURL
        case siteAdmin
        case hireable
        case bio
        case twitterUsername
        case numberOfFollowers = "followers"
        case numberOfFollowing = "following"
        case createdAt
        case updatedAt
        case numberOfPrivateGists = "private_gists"
        case numberOfOwnPrivateRepos = "owned_private_repos"
        case amountDiskUsage = "disk_usage"
        case numberOfCollaborators = "collaborators"
        case twoFactorAuthenticationEnabled = "two_factor_authentication"
        case subscriptionPlan = "plan"
    }
}

// MARK: - Model - GitHub repository
// ref: https://github.com/nerdishbynature/octokit.swift/blob/main/OctoKit/Repositories.swift
struct GitHubRepositoryModel: Decodable {
    let id: Int
    let owner: GitHubUser
    let name: String?
    let fullName: String?
    let isPrivate: Bool
    let repositoryDescription: String?
    let isFork: Bool
    let gitURL: String?
    let sshURL: String?
    let cloneURL: String?
    let htmlURL: String?
    let size: Int?
    let lastPush: String? // Date に直したいなら別途処理を書く必要がある
    let stargazersCount: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case owner
        case name
        case fullName
        case isPrivate = "private"
        case repositoryDescription = "description"
        case isFork = "fork"
        case gitURL
        case sshURL
        case cloneURL
        case htmlURL
        case size
        case lastPush = "pushed_at"
        case stargazersCount
    }
}
