//
//  SecondViewController.swift
//  CardGame
//
//  Created by amit lupo  on 7/3/24.
//

import Foundation
import UIKit

class WelcomeViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var LBL_welcome: UILabel!
    @IBOutlet var BTN_submitName: UIView!
    @IBOutlet weak var TF_insertName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        TF_insertName.isUserInteractionEnabled = true
        checkNameExist();
    }
    
    
    
    func checkNameExist(){
        if let value = UserDefaults.standard.string(forKey: "username"){
            LBL_welcome.isHidden = false
            LBL_welcome.text = "Hi \(value)"
        }else{
            LBL_welcome.isHidden = true
            TF_insertName.isHidden = false
            BTN_submitName.isHidden = false
        }
    }
    
    @IBAction func setName(_ sender: Any) {
        if let username : String = TF_insertName.text {
            UserDefaults.standard.set(username, forKey: "username")
            LBL_welcome.text = "Hi \(username)"
            LBL_welcome.isHidden = false
//            BTN_submitName.isHidden = true
        }
        
    }
    
    @IBAction func startGame(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        let secondController = storyboard.instantiateViewController(withIdentifier: "GameView")
        self.present(secondController, animated: true,completion: nil)
    }
}
