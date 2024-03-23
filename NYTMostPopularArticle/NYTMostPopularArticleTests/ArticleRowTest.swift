//
//  ArticleRowTest.swift
//  NYTimesTests
//
//  Created by ios on 23/03/2024.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import NYTMostPopularArticle

class ArticleRowTest: XCTestCase {
    
    func testArticleRow() throws {
        let article = ArticleInfo(id: 1, title: "Title 1",section: "section", subsection: "", byline: "Byline 1", published_date: "2024-01-01", abstract: "Abstract 1", url: "URL 1", updated: "", media: [Media(mediaMetadata: [MediaMetadatum(url: "https://static01.nyt.com/images/2024/03/19/multimedia/KRISTI-NOEM-STYLE-01-hbjm/KRISTI-NOEM-STYLE-01-hbjm-mediumThreeByTwo210.jpg", format: "", height: 100, width: 100)])], adx_keywords: "Keywords 1")
        
        let articleRow = ArticleRow(article: article)
        
        let asyncImage = try articleRow.inspect().hStack().image
        XCTAssertNotNil(asyncImage)
        
        let titleText = try articleRow.inspect().hStack().vStack(1).text(0).string()
        XCTAssertEqual(titleText, "Title 1")
        
        let bylineText = try articleRow.inspect().hStack().vStack(1).hStack(1).text(0).string()
        XCTAssertEqual(bylineText, "Byline 1")
      
        let publishedDateText = try articleRow.inspect().hStack().vStack(1).hStack(1).text(3).string()
        XCTAssertEqual(publishedDateText, "2024-01-01")
    }
}
