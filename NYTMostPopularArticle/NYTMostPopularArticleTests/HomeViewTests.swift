//
//  HomeViewTests.swift
//  NYTimesTests
//
//  Created by ios on 22/03/2024.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import NYTMostPopularArticle

class HomeViewTests: XCTestCase {
    
    func testArticleList() throws {
        let viewModel = MockArticleViewModel()
        viewModel.articleList = [
            ArticleInfo(id: 1, title: "Title 1",section: "section", subsection: "", byline: "Byline 1", published_date: "2024-01-01", abstract: "Abstract 1", url: "URL 1", updated: "", media: [], adx_keywords: "Keywords 1"),
            ArticleInfo(id: 2, title: "Title 2",section: "section", subsection: "", byline: "Byline 2", published_date: "2024-01-02", abstract: "Abstract 2", url: "URL 2", updated: "", media: [], adx_keywords: "Keywords 2")
        ]
        
        let homeView = HomeView(viewModel: viewModel)
        
        let customNav = try homeView.inspect().find(CustomNavigationBar.self)
        let navTitle = try customNav.find(ViewType.Text.self)
        XCTAssertEqual(try navTitle.string(), "NY Times Most Popular")
        try homeView.inspect().find(ViewType.LazyVStack.self).forEach { vStack in
            try vStack.find(ArticleRow.self).forEach { row in
                let titleText = try row.find(ViewType.Text.self).string()
                print(titleText)
                XCTAssertNotNil(titleText)
                XCTAssertTrue(titleText == "Title 1" || titleText == "Title 2")
            }
        }
    }
    
    
    func testOnAppearFetch() throws {
        let viewModel = MockArticleViewModel()
        viewModel.fetchArticlesCalled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(viewModel.fetchArticlesCalled)
            XCTAssertEqual(viewModel.articleList.count, 2)
        }
    }
}

// Mock ArticleViewModel for testing
class MockArticleViewModel: ArticleViewModel {
    var fetchArticlesCalled = false
    var mockArticles: [ArticleInfo] = []
    
    override func fetchArticles() {
        fetchArticlesCalled = true
        articleList = mockArticles
    }
    
}
