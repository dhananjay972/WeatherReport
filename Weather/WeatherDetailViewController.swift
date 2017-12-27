//
//  WeatherDetailViewController.swift
//  Weather
//
//  Created by DJ on 26/22/17.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var pressureLbl: UILabel!
    
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!
    var Humidity:String!
    var Pressure:String!
    var minTemp:String!
    var maxTemp:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set values to labels 
        humidityLbl.text? = Humidity
        pressureLbl.text? = Pressure
        maxTempLbl.text? = maxTemp+" °C"
        minTempLbl.text? = minTemp+" °C"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
