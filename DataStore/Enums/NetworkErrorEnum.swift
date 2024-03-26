//
//  NetworkEnum.swift
//  APICallTutorial
//
//  Created by SCOTT CROWDER on 3/18/24.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
    case unknownError
}
