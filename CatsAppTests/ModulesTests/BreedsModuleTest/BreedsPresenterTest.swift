//
//  BreedsPresenterTest.swift
//  CatsAppTests
//
//  Created by Marat on 11.02.2023.
//

import XCTest
@testable import CatsApp

class MockView: BreedsViewProtocol {
    private(set) var isUpdated = false
    func updateBreeds() {
        isUpdated = true
    }
    
    func setBreedImage(at indexPath: IndexPath, with imgLink: String?) {
        
    }
}

enum MockError: Error {
    case mockError
}

class MockService: BreedsService {
    var passSuccess = false
    func fetchData(_ completion: @escaping (Result<Breeds, Error>) -> Void) {
        if passSuccess {
            completion(.success(Breeds()))
        } else {
            completion(.failure(MockError.mockError))
        }
    }
    
    func fecthImageLink(imageId: String, _ completion: @escaping (Result<String?, Error>) -> Void) {
        completion(.failure(MockError.mockError))
    }
}

class BreedsPresenterTest: XCTestCase {
    
    var view: MockView!
    var service: MockService!
    var presenter: BreedsViewPresenterProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        view = MockView()
        service = MockService()
        presenter = BreedsPresenter(view: view, service: service)
    }

    override func tearDownWithError() throws {
        view = nil
        service = nil
        presenter = nil
        try super.tearDownWithError()
    }
    
    func testPresenterGetBreedsFailed() {
        // given
        
        // when
        presenter.getBreeds()
        
        // then
        XCTAssertFalse(view.isUpdated)
    }
    
    func testPresenterGetBreedsSuccess() {
//        // given
//        service.passSuccess = true
//        let promise = expectation(description: "Updated")
//
//        // when
//        presenter.getBreeds()
//        promise.fulfill()
//
//        // then
//        wait(for: [promise], timeout: 5)
    }
}
