//
//  File.swift
//  
//
//  Created by Tarun Khurana on 5/20/24.
//

import Foundation
import Dependencies
import Network

struct NetworkURLSessionKey: DependencyKey {
    static var liveValue: NetworkURLSession = DefaultNetworkURLSession()
}

extension DependencyValues {
    public var networkURLSession: NetworkURLSession {
        get { self[NetworkURLSessionKey.self] }
        set { self[NetworkURLSessionKey.self] = newValue}
    }
}
