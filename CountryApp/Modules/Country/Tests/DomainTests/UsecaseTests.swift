import XCTest
import Dependencies
@testable import Country

final class UsecaseTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Usecase_execute_shouldSucceed() async throws {
        // Given
        let userCase = withDependencies {
            $0.repositoryCountry = MockCountryRepository(shouldSucceed: true)
        } operation: {
            CountryUsecaseImpl()
        }

        let totalCountriesCount = 249
        
        // When
        let countries = try await userCase.execute()
        
        // Then
        XCTAssertEqual(totalCountriesCount, countries.count)

    }
    
    func test_Usecase_execute_shouldError() async throws {
        // Given
        let userCase = withDependencies {
            $0.repositoryCountry = MockCountryRepository(shouldBeError: true)
        } operation: {
            CountryUsecaseImpl()
        }
        var errorCountry: CountryError?
        // When
        do {
            _ = try await userCase.execute()
        } catch {
            errorCountry = error as? CountryError
        }
        
        // Then
        XCTAssertEqual(errorCountry, CountryError.noDataFound)

    }
    
}
