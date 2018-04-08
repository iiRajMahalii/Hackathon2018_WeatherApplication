//
//  WeatherAPIClient.swift
//  Hackathon2018_WeatherApplication
//
//  Created by Suraj Patel on 4/7/18.
//  Copyright © 2018 Suraj Patel. All rights reserved.
//

import Foundation

class weatherAPIClient: APIClient {
    
    var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func weather(with endpoint: WeatherEndpoint, completion: @escaping (Either<ForecastText, APIError>) -> Void) {
        let request = endpoint.request
        self.fetch(with: request) { (either: Either<Weather, APIError>) in
            switch either {
            case .value(let textForecast):
                let weather = textForecast.forecast.forecastText
                completion(.value(weather))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
}
