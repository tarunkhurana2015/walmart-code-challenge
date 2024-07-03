//
//  File.swift
//  
//
//  Created by Tarun Khurana on 5/20/24.
//

import Foundation

public enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
}

public extension ClosedRange<Int> {
    /// A range of "success" status codes (2xx).
    static let successStatusCodes: Self = 200 ... 299
    static let serverErrorResponseCodes: Self = 500 ... 599
}

// HTTP Status Codes Constants
public enum HttpStatusCodes {
    public static let OK = 200
    public static let badRequest = 400
    public static let unauthorized = 401
    public static let pageNotFound = 404
    public static let internalServerError = 500
}
