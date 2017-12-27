//
//  WeatherTableViewController.swift
//  Weather
//
//  Created by DJ on 26/22/17.
//

import UIKit
//import MBProgressHUD.h

class WeatherTableViewController: UITableViewController {
    //array to store Names of city
    var cityNamesArray = [String]()
    //array to store temp of city
    var tempCity = [String]()
    var cityHumidity = [String]()
    var cityPressure = [String]()
    var cityMinTemp = [String]()
    var cityMaxTemp = [String]()
    //tebleview cell Identifier
    let tableVieCellIdentifier = "HomeTableCell"
    let melborneURL = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?id=2147714&units=metric&APPID=1e2b616a507ebafa30cf2bb31ceb4880")!
    let brisbaneURL = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?id=2174003&units=metric&APPID=1e2b616a507ebafa30cf2bb31ceb4880")!
    let sydneyURL = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?id=4163971&units=metric&APPID=1e2b616a507ebafa30cf2bb31ceb4880")!
    
    var HumidityVal:String!
    var PressureVal:String!
    var minTempVal:String!
    var maxTempVal:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityNamesArray = ["Sydney","Melbourne","Brisbane"]
        
        if Reachability.isConnectedToNetwork(){
            SVProgressHUD.show(withStatus: "Fetching Data from server")
            getJsonFromUrl()
        }else{
            let alert = UIAlertController(title: "Alert", message: "Please check your internet connection", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

        self.refreshControl?.addTarget(self, action: "refresh:", for: UIControlEvents.valueChanged)
    
    }
    
    func refresh(sender:AnyObject)
    {
        // Updating your data here...

        SVProgressHUD.show(withStatus: "Fetching Data from server")
        getJsonFromUrl()
        self.refreshControl?.endRefreshing()
    }

    //this function is fetching the json from URL
    func getJsonFromUrl(){
        //creating a NSURL
        //fetching the data from the url for Sydney
        URLSession.shared.dataTask(with: (self.sydneyURL as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if let error = error {
                // Case 1: Error
                // We got some kind of error while trying to get data from the server.
                print("Error:\n\(error)")
                self.showAlertError()
            }
            else {
                // Case 2: Success
                // We got a response from the server!
                
                            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                                if let main = jsonObj!.value(forKey: "main")! as? NSDictionary {
                                    if let temp = main["temp"] {
                                        self.tempCity.append("\(temp) ")
                                        self.cityHumidity.append("\(main["humidity"] ?? "N.A")")
                                        self.cityPressure.append("\(main["pressure"] ?? "N.A")")
                                        self.cityMinTemp.append("\(main["temp_min"] ?? "N.A")")
                                        self.cityMaxTemp.append("\(main["temp_max"] ?? "N.A")")
                                        //Get melborne City data
                                        self.melBorneRwquest()
                                    }
                                }
                                
                            }
            }

        }).resume()
    }
    
    func melBorneRwquest() {
        //afer complicion of first request make second request call
        //fetching the data from the url for melborne
        URLSession.shared.dataTask(with: (self.melborneURL as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if let error = error {
                // Case 1: Error
                // We got some kind of error while trying to get data from the server.
                print("Error:\n\(error)")
                self.showAlertError()
            }
            else {
                // Case 2: Success
                // We got a response from the server!
                let dataString = String(data: data!, encoding: String.Encoding.utf8)
                
                if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                    
                    if let main = jsonObj!.value(forKey: "main")! as? NSDictionary {
                        if let temp = main["temp"] {
                            self.tempCity.append("\(temp)")
                            self.cityHumidity.append("\(main["humidity"] ?? "N.A")")
                            self.cityPressure.append("\(main["pressure"] ?? "N.A")")
                            self.cityMinTemp.append("\(main["temp_min"] ?? "N.A")")
                            self.cityMaxTemp.append("\(main["temp_max"] ?? "N.A")")
                            //get Brisbane city data
                            self.brisbaneRequest()
                        }
                    }
                    
                }
            }
            
        }).resume()
    }
    
    func brisbaneRequest() {
        //fetching the data from the url for brisbane
        URLSession.shared.dataTask(with: (self.brisbaneURL as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if let error = error {
                // Case 1: Error
                // We got some kind of error while trying to get data from the server.
                print("Error:\n\(error)")
                self.showAlertError()
            }
            else {
                // Case 2: Success
                // We got a response from the server!
                let dataString = String(data: data!, encoding: String.Encoding.utf8)
                
                if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                    
                
                    if let main = jsonObj!.value(forKey: "main")! as? NSDictionary {
                        if let temp = main["temp"] {
                            self.tempCity.append("\(temp)")
                            self.cityHumidity.append("\(main["humidity"] ?? "N.A")")
                            self.cityPressure.append("\(main["pressure"] ?? "N.A")")
                            self.cityMinTemp.append("\(main["temp_min"] ?? "N.A")")
                            self.cityMaxTemp.append("\(main["temp_max"] ?? "N.A")")
                            self.tableView.reloadData()
                            
                        }
                    }
                    
                }
            }
            
        }).resume()
    }

    func showAlertError()  {
        let alert = UIAlertController(title: "Alert", message: "Error in connection,Please ck ur Network comnnection", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        SVProgressHUD.dismiss()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tempCity.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        SVProgressHUD.dismiss()
        let cell = tableView.dequeueReusableCell(withIdentifier: tableVieCellIdentifier, for: indexPath) as! WeatherTableViewCell
        cell.cityLabel?.text = cityNamesArray[indexPath.row]
        cell.tempLabel?.text = tempCity[indexPath.row]+" °C"
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get Cell Label
      //  let indexPath = tableView.indexPathForSelectedRow!
        HumidityVal = cityHumidity[indexPath.row]
        PressureVal = cityPressure[indexPath.row]
        minTempVal = cityMinTemp[indexPath.row]
        maxTempVal = cityMaxTemp[indexPath.row]
        let viewController = storyboard?.instantiateViewController(withIdentifier: "WeatherDetailViewController") as! WeatherDetailViewController
        viewController.Humidity = HumidityVal
        viewController.Pressure = PressureVal
        viewController.minTemp = minTempVal
        viewController.maxTemp = maxTempVal
        navigationController?.pushViewController(viewController, animated: true)
    }

}
