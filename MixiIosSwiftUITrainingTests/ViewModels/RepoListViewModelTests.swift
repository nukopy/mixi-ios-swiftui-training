//
//  RepoListViewModelTests.swift
//  MixiIosSwiftUITrainingTests
//
//  Created by nukopy on 2023/03/27
//

import XCTest
@testable import MixiIosSwiftUITraining

@MainActor
final class RepoListViewModelTests: XCTestCase {
    func test_onAppear_正常系() async {
        // given (前提条件):
        let want: [Repo] = [.mock1, .mock2]
        let mockUsecase = MockGetRepositoriesOfSpecificUserUseCase(repos: want, error: nil)
        let viewModel = RepoListViewModel(usecase: mockUsecase)
        
        // when (操作):
        await viewModel.onAppear()
        
        // then (期待する結果):
        switch viewModel.dataLoadingState {
        case .Successed(let actual):
            XCTAssertEqual(actual, want)
        default:
            XCTFail()
        }
    }
    
    func test_onAppear_異常系() async {
        // given (前提条件):
        let mockUsecase = MockGetRepositoriesOfSpecificUserUseCase(repos: [Repo](), error: DummyError())
        let viewModel = RepoListViewModel(usecase: mockUsecase)
        
        // when (操作):
        await viewModel.onAppear()
        
        // then (期待する結果):
        switch viewModel.dataLoadingState {
        case .Failed(let error):
            XCTAssert(error is DummyError)
        default:
            XCTFail()
        }
    }
}
