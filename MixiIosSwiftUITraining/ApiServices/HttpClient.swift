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
        var data: Data?
        var response: URLResponse?
        
        do {
            (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let res = response as? HTTPURLResponse, res.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
        } catch let error {
            print("Error on HTTP request: \(error)")
            throw error
        }
        
        // decode response
        do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decodedData = try jsonDecoder.decode(ResponseType.self, from: data!)
            
            return decodedData
        } catch let error {
            print("Response: \(response!)")
            print("Error decoding JSON: \(error)")
            
            // data を文字列として出力
            if let string = String(data: data!, encoding: .utf8) {
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
