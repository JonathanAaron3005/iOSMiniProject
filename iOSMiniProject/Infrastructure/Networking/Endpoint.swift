//
//  Endpoint.swift
//  iOSMiniProject
//
//  Created by Jonathan Aaron Wibawa on 05/12/24.
//

import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var body: Data? { get }
}

extension Endpoint {
    func urlRequest() async throws -> URLRequest {
        guard let url = constructURL() else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers ?? [:]
        request.httpBody = try prepareRequestBody()
        setDefaultHeaders(for: &request)
        
        return request
    }

    private func constructURL() -> URL? {
        var components = URLComponents(string: "\(baseURL)\(path)")
        
        if method == .get, let parameters = parameters {
            components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        return components?.url
    }
    
    private func prepareRequestBody() throws -> Data? {
        if let body = body {
            return body
        }
        
        guard method != .get, let parameters = parameters else {
            return nil
        }
        
        return try JSONSerialization.data(withJSONObject: parameters)
    }

    private func setDefaultHeaders(for request: inout URLRequest) {
        if let contentType = headers?["Content-Type"] {
            request.setValue(contentType, forHTTPHeaderField: "Content-Type")
            request.setValue(headers?["Accept"] ?? contentType, forHTTPHeaderField: "Accept")
        }
    }
}

