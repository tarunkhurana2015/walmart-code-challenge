//
//  RepositoryTests.swift
//  
//
//  Created by Tarun Khurana on 5/22/24.
//

import XCTest
import Dependencies
@testable import Country
@testable import Network

final class RepositoryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Repository_getCountries_suceess() async throws {
        // Given
        let repository = withDependencies {
            $0.networkURLSession = MockNetworkURLSession()
        } operation: {
            CountryRepository()
        }
        let totalCountriesCount = 249
        
        // When
        let countries = try await repository.getCountries()
        
        // Then
        XCTAssertEqual(totalCountriesCount, countries.count)
    }
    
    func test_Repository_getCountries_error() async throws {
        // Given
        let repository = withDependencies {
            $0.networkURLSession = MockNetworkURLSession(shouldBeError: true)
        } operation: {
            CountryRepository()
        }
        var networkError: NetworkError?
        // When
        do {
            _ = try await repository.getCountries()
        } catch {
            networkError = error as? NetworkError
        }
        
        // Then
        XCTAssertNotNil(networkError)
    }

}
