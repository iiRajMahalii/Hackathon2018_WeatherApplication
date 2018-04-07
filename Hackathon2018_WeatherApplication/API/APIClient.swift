//
//  APIClient.swift
//  Hackathon2018_WeatherApplication
//
//  Created by Suraj Patel on 4/7/18.
//  Copyright © 2018 Suraj Patel. All rights reserved.
//

import Foundation

enum Either<v, E: Error> {
    case value(v)
    case error(E)
}

enum APIError: Error {
    case apiError
    case badRequest
    case jsonDecoder
    case unknown(String)
}

protocol APIClient {
    var session: URLSession { get }
    func fetch<v: Codable>(with request: URLRequest, completion: @escaping (Either<v, APIError>) -> Void)
}

extension APIClient {
    func fetch<v: Codable>(with request: URLRequest, completion: @escaping (Either<v, APIError>) -> Void) {
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else{
                completion(.error(.apiError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else{
                completion(.error(.badResponse))
                return
            }
            
            guard let value = try? JSONDecoder().decode(v.self, from: data!) else {
                completion(.error(.jsonDecoder))
                return
            }
        }
    }
}
