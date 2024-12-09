//
//  NetworkManager.swift
//  iOSMiniProject
//
//  Created by Jonathan Aaron Wibawa on 05/12/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum EncodingType {
    case url
    case json
}

protocol NetworkManaging {
    func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T
}

final class NetworkManager: NetworkManaging {
    static let shared = NetworkManager()
    private let session: URLSession
    
    private init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T {
        let request = try await endpoint.urlRequest()
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        if let responseBody = String(data: data, encoding: .utf8) {
            print("Response Body: \(responseBody)")
        }
        
        try validateResponse(httpResponse)
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom { decoder -> Date in
                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                formatter.timeZone = TimeZone(identifier: "UTC")
                
                if let date = formatter.date(from: dateString) {
                    return date
                } else {
                    throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format")
                }
            }
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
    
    private func validateResponse(_ response: HTTPURLResponse) throws {
        switch response.statusCode {
        case 200...299:
            return
        case 400...499:
            throw NetworkError.clientError(response.statusCode)
        case 500...599:
            throw NetworkError.serverError(response.statusCode)
        default:
            throw NetworkError.unknownError(response.statusCode)
        }
    }
}

