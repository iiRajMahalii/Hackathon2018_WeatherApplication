//
//  WeatherCellViewModel.swift
//  Hackathon2018_WeatherApplication
//
//  Created by Suraj Patel on 4/7/18.
//  Copyright © 2018 Suraj Patel. All rights reserved.
//

import UIKit

struct WeatherCellViewModel {
    let url: URL
    let day: String
    let description: String
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        guard let imageData = try? Data(contentsOf: url) else {
            return
        }
        
        let image = UIImage(data: imageData)
        DispatchQueue.main.async {
            completion(image)
        }
        
    }
}

