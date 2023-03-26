//
//  HttpClient.swift
//  MixiIosSwiftUITraining
//
//  Created by nukopy on 2023/03/26
//

import Foundation

enum HttpMethod: String {
    case GET
    case POST
}

typealias Headers = [String: String]
typealias QueryParams = [String: String]

class HttpClient {
    static func get<ResponseType: Decodable>(url: String, headers: Headers, queryParams: QueryParams) async throws -> ResponseType {
        // create request
        let urlRequest = createUrlRequest(url: url, httpMethod: .GET, headers: headers, queryParams: queryParams)
        
        // request
        let (data, response) = try! await URLSession.shared.data(for: urlRequest)
        
        // decode response
        do {
            let decodedData = try JSONDecoder().decode(ResponseType.self, from: data)
            
            return decodedData
        } catch let error {
            print("Response: \(response)")
            print("Error decoding JSON: \(error)")
            
            // data を文字列として出力
            if let string = String(data: data, encoding: .utf8) {
                print("response string: \(string)")
            }
            throw error
        }
    }
    
    static private func createUrlRequest(url: String, httpMethod: HttpMethod, headers: Headers, queryParams: QueryParams) -> URLRequest {
        // build URL with query-string
        var urlComponents = URLComponents(string: url)!
        if !queryParams.isEmpty {
            let queryItems = queryParams.map { key, value in
                URLQueryItem(name: key, value: value)
            }
            
            urlComponents.queryItems = queryItems
        }
        
        // create request
        let urlObj = urlComponents.url ?? URL(string: url)!
        var urlRequest = URLRequest(url: urlObj)
        urlRequest.httpMethod = HttpMethod.GET.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        return urlRequest
    }
}
