//
//  GetGitHubRepositoriesOfSpecificUserUseCaseTests.swift
//  GetGitHubRepositoriesOfSpecificUserUseCaseTests
//
//  Created by nukopy on 2023/03/27
//

import XCTest
@testable import MixiIosSwiftUITraining

final class GetGitHubRepositoriesOfSpecificUserUseCaseTests: XCTestCase {
    func test_execute_正常系() async {
        // given (前提条件):
        let want: [Repo] = [.mock1, .mock2]
        let usecase = GetGitHubRepositoriesOfSpecificUserUseCase(
            githubRepository: MockGitHubRepository(repos: want, error: nil)
        )
        let searchType: SearchType = .Username
        let searchQuery: String = "nukopy"
        
        // when (操作):
        var actual = [Repo]()
        do {
            actual = try await usecase.execute(searchType: searchType, searchQuery: searchQuery)
        } catch {
            XCTFail()
        }
        
        // then (期待する結果):
        XCTAssertEqual(actual, want)
    }
    
    func test_execute_異常系() async {
        // given (前提条件):
        let usecase = GetGitHubRepositoriesOfSpecificUserUseCase(
            githubRepository: MockGitHubRepository(repos: [Repo](), error: DummyError())
        )
        let searchType: SearchType = .Username
        let searchQuery: String = "nukopy"
        
        // when (操作):
        do {
            let _ = try await usecase.execute(searchType: searchType, searchQuery: searchQuery)
        } catch let error {
            // then (期待する結果):
            XCTAssert(error is DummyError)
        }
    }
}
