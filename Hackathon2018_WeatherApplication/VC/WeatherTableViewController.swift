//
//  WeatherTableViewController.swift
//  Hackathon2018_WeatherApplication
//
//  Created by Suraj Patel on 4/7/18.
//  Copyright © 2018 Suraj Patel. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {

    var cellViewModels = [WeatherCellViewModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let topColor = UIColor(red: (192.0/255.0), green: (192.0/255.0), blue: (192.0/255.0), alpha: 1)
        let bottomColor = UIColor(red: (128.0/255.0), green: (128.0/255.0), blue: (128.0/255.0), alpha: 1)
        
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [Float] = [0.0,1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        */
        let weatherApi = weatherAPIClient()
        let weatherEndpoint = WeatherEndpoint.tenDayForecast(city: "Los Angeles", state: "CA")
        weatherApi.weather(with: weatherEndpoint) { (either) in
            switch either {
            case .value(let forecastText):
                print(forecastText)
                self.cellViewModels = forecastText.forecastDays.map {
                    WeatherCellViewModel(url: $0.iconURL, day: $0.day, description: $0.description)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .error(let error):
                print(error)
                
            }
        }
    }
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellViewModels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Weather Cell", for: indexPath)

        // Configure the cell...
        let cellViewModel = cellViewModels [indexPath.row]
        cell.textLabel?.text = cellViewModel.day
        cell.detailTextLabel?.text = cellViewModel.description
        cellViewModel.loadImage { (image) in
            cell.imageView?.image = image
            
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
