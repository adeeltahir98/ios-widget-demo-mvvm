//
//  NetworkManager.swift
//  Weather
//
//  Created by Adeel Tahir on 16/12/2022.
//

import UIKit
import Combine

enum NetworkError: Error, LocalizedError {
    case invalidHTTPResponse, invalidServerResponse, jsonParsingError, apiError(reason: String)

    var errorDescription: String? {
        switch self {
        case .invalidHTTPResponse:
            return "Invalid HTTP response"
        case .invalidServerResponse:
            return "Invalid service sesponse"
        case .jsonParsingError:
            return "Error parsing JSON"
        case .apiError(let reason):
            return reason
        }
    }
}

class NetworkManager<response: Codable> {
    
    static func fetchRequest(apiUrl: String) -> AnyPublisher<response, NetworkError> {
        guard let url = URL(string: apiUrl) else { fatalError("Invalid API") }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, networkResponse -> response in
                guard let httpResponse = networkResponse as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.invalidHTTPResponse
                }
                let value = try JSONDecoder().decode(response.self, from: data)
                return value
            }
            .mapError { error in
                if let _ = error as? DecodingError {
                    return NetworkError.jsonParsingError
                } else if let error = error as? NetworkError {
                    return error
                }
                
                return NetworkError.invalidServerResponse
            }
            .eraseToAnyPublisher()
    }
}
