//
//  ArticleDetailsViewTest.swift
//  NYTimesUITests
//
//  Created by ios on 23/03/2024.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import NYTMostPopularArticle

class ArticleDetailsViewTest: XCTestCase {
    
    func testRendering() {
        let article = ArticleInfo(id: 1, title: "Title" ,section: "section", subsection: "subsection", byline: "Bylinehjhhhhhhhhh hhhhhhhhhh hhhh", published_date: "vcr", abstract: "vr", url: "https://static01.nyt.com/images/2024/03/19/multimedia/KRISTI-NOEM-STYLE-01-hbjm/KRISTI-NOEM-STYLE-01-hbjm-mediumThreeByTwo210.jpg", updated: "", media: [Media(mediaMetadata: [MediaMetadatum(url: "https://static01.nyt.com/images/2024/03/19/multimedia/KRISTI-NOEM-STYLE-01-hbjm/KRISTI-NOEM-STYLE-01-hbjm-mediumThreeByTwo210.jpg", format: "", height: 100, width: 100)])], adx_keywords: "d")
        
        let view = ArticleDetailView(article: article)
        XCTAssertNoThrow(view)
    }
    
    func testBackButtonAction() {
        let article = ArticleInfo(id: 1, title: "Title" ,section: "section", subsection: "subsection", byline: "Bylinehjhhhhhhhhh hhhhhhhhhh hhhh", published_date: "vcr", abstract: "vr", url: "https://static01.nyt.com/images/2024/03/19/multimedia/KRISTI-NOEM-STYLE-01-hbjm/KRISTI-NOEM-STYLE-01-hbjm-mediumThreeByTwo210.jpg", updated: "", media: [Media(mediaMetadata: [MediaMetadatum(url: "https://static01.nyt.com/images/2024/03/19/multimedia/KRISTI-NOEM-STYLE-01-hbjm/KRISTI-NOEM-STYLE-01-hbjm-mediumThreeByTwo210.jpg", format: "", height: 100, width: 100)])], adx_keywords: "d")
        
        var isBackButtonTapped = false
        
        let view = ArticleDetailView(article: article)
        try! view.inspect().find(CustomNavigationBar.self).vStack(0).hStack(0).button(0).tap()
        isBackButtonTapped = true
        XCTAssertTrue(isBackButtonTapped)
        
    }
    func testViewButtonAction() {
        let article = ArticleInfo(id: 1, title: "Title" ,section: "section", subsection: "subsection", byline: "Bylinehjhhhhhhhhh hhhhhhhhhh hhhh", published_date: "vcr", abstract: "vr", url: "https://static01.nyt.com/images/2024/03/19/multimedia/KRISTI-NOEM-STYLE-01-hbjm/KRISTI-NOEM-STYLE-01-hbjm-mediumThreeByTwo210.jpg", updated: "", media: [Media(mediaMetadata: [MediaMetadatum(url: "https://static01.nyt.com/images/2024/03/19/multimedia/KRISTI-NOEM-STYLE-01-hbjm/KRISTI-NOEM-STYLE-01-hbjm-mediumThreeByTwo210.jpg", format: "", height: 100, width: 100)])], adx_keywords: "d")
        
        var isViewButtonTapped = false
        
        let view = ArticleDetailView(article: article)
        try! view.inspect().find(CustomNavigationBar.self).vStack(0).hStack(0).button(4).tap()
        isViewButtonTapped = true
        XCTAssertTrue(isViewButtonTapped)
        
    }

    func testTextValues() {
        let article = ArticleInfo(id: 1, title: "Title 1",section: "section", subsection: "", byline: "Byline 1", published_date: "2024-01-01", abstract: "Abstract 1", url: "URL 1", updated: "2024-03-20 22:58:47", media: [], adx_keywords: "Keywords 1")
        
        let view = ArticleDetailView(article: article)
        
        let inspectableView = try! view.inspect()
        
        let scrollView  = try! inspectableView.find(ViewType.ScrollView.self)
        let titleText = try! scrollView.find(text: "Title 1").string()
        XCTAssertEqual(titleText, "Title 1")
        
        let bylineText = try! scrollView.find(text: "Byline 1").string()
        XCTAssertEqual(bylineText, "Byline 1")
        
        let publishedDateText = try! scrollView.find(text: "Published On: 2024-01-01").string()
        XCTAssertEqual(publishedDateText, "Published On: 2024-01-01")
        
        let updatedOnText = try! scrollView.find(text: "Updated On: 2024-03-20").string()
        XCTAssertTrue(updatedOnText.starts(with: "Updated On: "))
        let updatedDate = updatedOnText.replacingOccurrences(of: "Updated On: ", with: "")
        XCTAssertEqual(updatedDate, "2024-03-20")
        
        let abstractText = try! scrollView.find(text: "Abstract 1").string()
        XCTAssertEqual(abstractText, "Abstract 1")
    }
}
