//
//  ViewModelTests.swift
//  
//
//  Created by Tarun Khurana on 5/22/24.
//

import XCTest
import Combine
import Dependencies
@testable import Country

final class ViewModelTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cancellables.removeAll()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_ViewModel_fetchCountries_shouldSucceed() async throws {
        // Given
        let viewModel = await withDependencies {
            $0.userCaseCountry = MockCountryUsecaseImpl(shouldSucceed: true)
        } operation: {
            await CountryViewModel()
        }

        let totalCountriesCount = 249
        let expectation = XCTestExpectation(description: #function)
        
        // When
        await viewModel.fetchCountries()
        
        // Then
        await viewModel.$viewState.sink { viewState in
            if case let .loaded(countries) = viewState {
                XCTAssertEqual(totalCountriesCount, countries.count)
                expectation.fulfill()
            }
            
        }
        .store(in: &cancellables)

        await fulfillment(of: [expectation])
    }
    
    func test_ViewModel_fetchCountries_shouldError() async throws {
        // Given
        let viewModel = await withDependencies {
            $0.userCaseCountry = MockCountryUsecaseImpl(shouldBeError: true)
        } operation: {
            await CountryViewModel()
        }

        let expectation = XCTestExpectation(description: #function)
        
        // When
        await viewModel.fetchCountries()
        
        // Then
        await viewModel.$viewState.sink { viewState in
            if case .error = viewState {
                XCTAssert(true)
                expectation.fulfill()
            }
            
        }
        .store(in: &cancellables)

        await fulfillment(of: [expectation])
    }
    
    func test_ViewModel_fetchCountries_shouldBeEmpty() async throws {
        // Given
        //let viewModel = await CountryViewModel()
        let viewModel = await withDependencies {
            $0.userCaseCountry = MockCountryUsecaseImpl(shouldBeEmpty: true)
        } operation: {
            await CountryViewModel()
        }

        let expectation = XCTestExpectation(description: #function)
        
        // When
        await viewModel.fetchCountries()
        
        // Then
        await viewModel.$viewState.sink { viewState in
            if case let .loaded(countries) = viewState {
                XCTAssertEqual(countries.count, 0)
                expectation.fulfill()
            }
            
        }
        .store(in: &cancellables)

        await fulfillment(of: [expectation])
    }
    
    func test_ViewModel_fetchCountries_withFilters_shouldSucceed() async throws {
        // Given
        let filterTerm = "America"
        let viewModel = await withDependencies {
            $0.userCaseCountry = MockCountryUsecaseImpl(shouldSucceed: true)
        } operation: {
            await CountryViewModel()
        }
        let totalCountriesCount = 2
        let expectation = XCTestExpectation(description: #function)
        
        // When
        await viewModel.fetchCountries()        
        await viewModel.filterCountries(with: filterTerm)
        
        // Then
        await viewModel.$viewState.sink { viewState in
            if case let .loaded(countries) = viewState {
                XCTAssertEqual(totalCountriesCount, countries.count)
                expectation.fulfill()
            }
            
        }
        .store(in: &cancellables)

        await fulfillment(of: [expectation])
    }

}
