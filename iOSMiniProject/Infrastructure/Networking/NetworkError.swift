//
//  NetworkError.swift
//  iOSMiniProject
//
//  Created by Jonathan Aaron Wibawa on 05/12/24.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case invalidURL
    case decodingFailed
    case clientError(Int)
    case serverError(Int)
    case unknownError(Int)
    case unauthorized(Int)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response received from the server."
        case .invalidURL:
            return "Invalid URL"
        case .decodingFailed:
            return "Failed to decode the response data."
        case .clientError(let statusCode):
            return "Client error occurred. Status code: \(statusCode)"
        case .serverError(let statusCode):
            return "Server error occurred. Status code: \(statusCode)"
        case .unknownError(let statusCode):
            return "An unknown error occurred. Status code: \(statusCode)"
        case .unauthorized(let statusCode) :
            return "Unauthorized. Status code : \(statusCode)"
        }
    }
}
