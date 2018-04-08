//
//  Endpoint.swift
//  Hackathon2018_WeatherApplication
//
//  Created by Suraj Patel on 4/7/18.
//  Copyright © 2018 Suraj Patel. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    var urlComponent: URLComponents {
        var component = URLComponents(string: baseURL)
        component?.path = path
        component?.queryItems = queryItems
        
        return component!
    }
    
    var request: URLRequest{
        return URLRequest(url: urlComponent.url!)
    }
    
}

enum WeatherEndpoint: Endpoint {
    
    case tenDayForecast(city: String, state: String)
    
    var baseURL: String {
        return "http://api.wunderground.com"
    }
    
    var path: String {
        switch self {
        case .tenDayForecast(let city, let state):
            return "/api/38b4d6e67c521b85/forecast10day/q/\(state)/\(city).json"
        
        }
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
}
