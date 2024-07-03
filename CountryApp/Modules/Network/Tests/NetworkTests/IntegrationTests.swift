import XCTest
@testable import Network

final class NetworkTests: XCTestCase {
    
    func test_Integration_NetworkURLSession_success() async throws {
        // Given
        let baseURL = "https://gist.githubusercontent.com"
        let basePath = "/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json"
        let networkSession = DefaultNetworkURLSession()
        let UrlRequest = URLRequest(url: URL(string: baseURL+basePath)!)
        
        // When
        let data = try await networkSession.request(UrlRequest)
        
        // Then
        XCTAssertTrue(!data.isEmpty) 
    }
    
}
