//
//  NewsAPIFormatterTests.swift
//  KeanuWatchTests
//
//  Created by Amanda Bloomer  on 1/21/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import XCTest
@testable import KeanuWatch

class NewsAPIFormatterTests: XCTestCase {
    var sut: NewsAPIFormatter!
    
    override func setUp() {
        super.setUp()
        sut = NewsAPIFormatter()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testNilTimestamp() {
        let input: String? = nil
        let result = sut.formatTimestamp(timestamp: input)
        
        XCTAssert(result == nil)
    }
    
    func testFormattingForExpectedInputOfPublishedAt() {
        let input: String? = "2020-01-21T12:15:14Z"
        let result = sut.formatTimestamp(timestamp: input)
        
        XCTAssert(result == "Date published: 01-21-2020")
    }
    
    func testFormattingForInputWithoutTSeparator() {
        let input: String? = "2020-01-2112:15:14Z"
        let result = sut.formatTimestamp(timestamp: input)
        
        XCTAssert(result == "Date published: 2020-01-2112:15:14Z")
    }
    
    func testFormattingForInputWithoutHyphenSeparator() {
        let input: String? = "20200121T12:15:14Z"
        let result = sut.formatTimestamp(timestamp: input)
        
        XCTAssert(result == "Date published: 20200121T12:15:14Z")
    }
    
    func testFormattingForInputWithNoSeparators() {
        let input: String? = "2020012112:15:14Z"
        let result = sut.formatTimestamp(timestamp: input)
        
        XCTAssert(result == "Date published: 2020012112:15:14Z")
    }
    
    func testFormattingForInputWithSeparatorCharactersAndBadFormat() {
        let input: String? = "What are you trying to tell me - That I can dodge bullets?"
        let result = sut.formatTimestamp(timestamp: input)
        
        XCTAssert(result == "Date published: What are you trying to tell me - That I can dodge bullets?")
    }
    
    func testFormattingForEmptyTimestamp() {
        let input: String? = ""
        let result = sut.formatTimestamp(timestamp: input)
        
        XCTAssert(result == "Date published: ")
    }
    
    func testFormattingForNilAuthorName() {
        let input: String? = nil
        let result = sut.formatAuthor(author: input)
        
        XCTAssert(result == nil)
    }
    
    func testFormattingForAuthorName() {
        let input: String? = "Mr. Anderson"
        let result = sut.formatAuthor(author: input)
        
        XCTAssert(result == "Author: Mr. Anderson")
    }

    func testFormattingForJunkAuthorName() {
        let input: String? = "AJS)D(*ASY*()&UIOHANFASDASD1456+A4D9/"
        let result = sut.formatAuthor(author: input)
        
        XCTAssert(result == "Author: AJS)D(*ASY*()&UIOHANFASDASD1456+A4D9/")
    }
    
    func testFormattingForEmptyAuthorName() {
        let input: String? = ""
        let result = sut.formatAuthor(author: input)
        
        XCTAssert(result == "Author: ")
    }
}
