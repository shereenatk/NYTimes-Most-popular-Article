//
//  ArticleViewModelTests.swift
//  NYTimesTests
//
//  Created by ios on 22/03/2024.
//

import XCTest
@testable import NYTMostPopularArticle

class ArticleViewModelTests: XCTestCase {
    
    func testFetchArticleSuccess() {
        let viewModel = ArticleViewModel()
        
        let jsonData = """
                {"status": "OK", "results": [ {"id": 1, "title": "Title", "byline": "Byline", "published_date": "2024-01-01", "abstract": "Abstract", "url": "https://nnnn.com", "updated": "2024-01-01", "media": [], "adx_keywords": [] } ]}
            """.data(using: .utf8)!
        
        
        let urlSessionMock = URLSessionMock(data: jsonData, response: nil, error: nil)
        viewModel.urlSession = urlSessionMock
        
        viewModel.fetchArticles()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertEqual(viewModel.articleList.count, 1)
            XCTAssertEqual(viewModel.articleList[0].title, "Title")
        }
       
    }
    
    func testFetchArticleFailure() {
        let viewModel = ArticleViewModel()
        
        let urlSessionMock = URLSessionMock(data: nil, response: nil, error: NSError(domain: "Test", code: 404, userInfo: nil))
        viewModel.urlSession = urlSessionMock
        
        
        viewModel.fetchArticles()
        
        XCTAssertTrue(viewModel.articleList.isEmpty)
    }
    
}

class URLSessionMock: URLSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockTask(data: data, response: response, error: error, completionHandler: completionHandler)
    }
}

class MockTask: URLSessionDataTask {
    private let data: Data?
    private let urlResponse: URLResponse?
    private let apiError: Error?
    private let completionHandler: (Data?, URLResponse?, Error?) -> Void
    
    init(data: Data?, response: URLResponse?, error: Error?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.data = data
        self.urlResponse = response
        self.apiError = error
        self.completionHandler = completionHandler
    }
    
    override func resume() {
        completionHandler(data, urlResponse, error)
    }
}
