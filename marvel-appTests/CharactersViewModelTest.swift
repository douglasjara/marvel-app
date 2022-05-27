//
//  CharactersViewModelTest.swift
//  marvel-appTests
//
//  Created by Douglas Jara Negrete on 26/5/22.
//

import XCTest
@testable import marvel_app

class CharactersViewModelTest: XCTestCase
{
    var sut: CharactersViewModel!
    
    override func setUpWithError() throws {
        sut = CharactersViewModel(charactersService: MockCharactersService())
    }

    override func tearDownWithError() throws {
        
    }

    func test_updateCharacterViewModels() throws {
        DispatchQueue.main.async {
            self.sut.refreshData()
        
            let expectedTotalCharacters = 1500
            let resultTotalCharacters = self.sut.totalCharacters
            
            let expectedNumberOfViewModels = 10
            let resultNumberOfViewModels = self.sut.characterViewModels.count
            
            XCTAssertEqual(expectedTotalCharacters, resultTotalCharacters)
            XCTAssertEqual(expectedNumberOfViewModels, resultNumberOfViewModels)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
