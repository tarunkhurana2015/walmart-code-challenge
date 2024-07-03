import Foundation

public protocol NetworkURLSession {
    func request(_ request: URLRequest) async throws -> Data
}

public struct DefaultNetworkURLSession: NetworkURLSession {
    
    public init() {}
    
    public func request(_ request: URLRequest) async throws -> Data {
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let response = response as? HTTPURLResponse,
                !ClosedRange.successStatusCodes.contains(response.statusCode) {
                // response status code not in range 200 ... 299
                throw NetworkError.error(statusCode: response.statusCode, data: data)
            }
            return data
            
        } catch {
            throw self.resolve(error: error)
        }
    }
}

extension DefaultNetworkURLSession {
    private func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .notConnected
        case .cancelled: return .cancelled
        default: return .generic(error)
        }
    }
}
