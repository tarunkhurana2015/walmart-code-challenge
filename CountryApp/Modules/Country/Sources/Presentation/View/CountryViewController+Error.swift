//
//  File.swift
//  
//
//  Created by Tarun Khurana on 5/21/24.
//

import Foundation
import Network

// All the messages can be loaclized, but for the scope of this project it's not localized.
extension CountryViewController {
    
    func mapErrortoMessage(error: Error) -> String {
        var message = ""
        if let error = error as? CountryError {
            switch error {
            case .noDataFound:
                message = "No Data Found"
            case .jsonDeocdingError:
                message = "JSON decoding failed"
            case .urlNotFound:
                message = "URL not found"
            case .unknown:
                message = "Unknow Error"
            }
        }
        if let error = error as? NetworkError {
            switch error {
            case .cancelled:
                message = "Request Cancelled"
            case .notConnected:
                message = "Internet Not connected"
            case .urlGeneration:
                message = "URL not found"
            case let .generic(error):
                message = "Generic Error: \(error.localizedDescription)"
            case let .error(statusCode, _):
                message = "Network error code: \(statusCode)"
            }
        }
        return message
    }
}
