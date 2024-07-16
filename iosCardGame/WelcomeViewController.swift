//
//  SecondViewController.swift
//  CardGame
//
//  Created by amit lupo  on 7/3/24.
//

import Foundation
import UIKit
import CoreLocation

class WelcomeViewController: UIViewController,UITextFieldDelegate{
    var locationManager: CLLocationManager!
    let MIDDLE: Double = 34.817549168324334
    
    var isLocationAvailable = false
    var playerSide : Direction!
    
    @IBOutlet weak var BTN_startGame: UIButton!
    @IBOutlet weak var IMG_west_earth: UIImageView!
    @IBOutlet weak var IMG_east_earth: UIImageView!
    @IBOutlet weak var LBL_welcome: UILabel!
    @IBOutlet weak var TF_insertName: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        initLocationManager()
        TF_insertName.delegate = self
        TF_insertName.isUserInteractionEnabled = true
        isAllowedToStart()
        
    }
    
    func isAllowedToStart() {
            if checkNameExist() && isLocationAvailable {
                BTN_startGame.isEnabled = true
            } else {
                BTN_startGame.isEnabled = false
            }
        }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss the keyboard
            
        if let text = textField.text {
            setName(text:text)
        }
            
        return true
    }
    
    func checkNameExist()->Bool{
        if let value = UserDefaults.standard.string(forKey: Constants.WelcomeScreen.USER_DEFAULTS_KEY){
            LBL_welcome.isHidden = false
            TF_insertName.isHidden = true
            LBL_welcome.text = "Hi \(value)"
            return true
        }else{
            LBL_welcome.isHidden = true
            TF_insertName.isHidden = false
            return false
        }
    }
    
    func setName(text : String) {
        UserDefaults.standard.set(text, forKey: Constants.WelcomeScreen.USER_DEFAULTS_KEY)
        TF_insertName.isHidden = true
        LBL_welcome.text = "Hi \(text)"
        LBL_welcome.isHidden = false
        isAllowedToStart()
    }
    
    @IBAction func startGame(_ sender: Any) {
        UserDefaults.standard.set(playerSide.rawValue, forKey: Constants.WelcomeScreen.PLAYER_SIDE_KEY)
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        let secondController = storyboard.instantiateViewController(withIdentifier: "GameView")
        self.present(secondController, animated: true,completion: nil)
    }
    
    func setUiWithLocation(lat: Double,lon: Double){
        if(lat > MIDDLE){
            //east
            IMG_east_earth.isHidden = false
            playerSide = Direction.east
        }else if (lat <= MIDDLE){
            //west
            IMG_east_earth.isHidden = false
            playerSide = Direction.west
        }
    }

}

extension WelcomeViewController: CLLocationManagerDelegate{
    
    func initLocationManager(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            setUiWithLocation(lat:lat,lon:lon)
            isLocationAvailable = true
            isAllowedToStart()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        isLocationAvailable = false
        print("Error=\(error)")
    }
    
}
