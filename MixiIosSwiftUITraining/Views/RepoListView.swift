//
//  RepoListView.swift
//  MixiIosSwiftUITraining
//
//  Created by nukopy on 2023/03/24
//

import SwiftUI
import CoreData

struct RepoListView: View {
    @State private var mockRepos: [Repo] = []
    
    var body: some View {
        NavigationView {
            if mockRepos.isEmpty {
                ProgressView("Loading...")
            } else {
                List(mockRepos) { repo in
                    NavigationLink(destination: RepoDetailView(repo: repo)
                        .navigationBarTitleDisplayMode(.inline)
                    ) {
                        RepoRowView(repo: repo)
                    }
                }
                .navigationTitle("Repositories")
            }
        }
        .onAppear {
            loadRepos()
        }
    }
    
    private func loadRepos() {
        // 1.5 秒後にモックデータを読み込む
        // TODO: API からデータを取得する処理に変える
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            mockRepos = [.mock1, .mock2, .mock3, .mock4, .mock5]
        }
    }
}

struct RepoListView_Previews: PreviewProvider {
    static var previews: some View {
        RepoListView()
    }
}
