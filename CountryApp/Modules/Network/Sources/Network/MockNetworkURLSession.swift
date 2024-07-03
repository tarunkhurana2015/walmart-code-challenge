import Foundation

public struct MockNetworkURLSession: NetworkURLSession {
    
    let shouldBeError: Bool
    
    public init(shouldBeError: Bool = false) {
        self.shouldBeError = shouldBeError
    }
    
    public func request(_ request: URLRequest) async throws -> Data {
        
        if shouldBeError {
            throw NetworkError.notConnected
        }
        if let url = Bundle.module.url(forResource: "Data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                throw error
            }
        }
        throw NetworkError.notConnected
    }
}
