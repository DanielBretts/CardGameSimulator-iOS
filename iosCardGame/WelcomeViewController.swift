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
    @IBOutlet weak var TF_insertName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TF_insertName.delegate = self
        TF_insertName.isUserInteractionEnabled = true
        checkNameExist();
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss the keyboard
            
        if let text = textField.text {
            setName(text:text)
        }
            
        return true
    }
    
    func checkNameExist(){
        if let value = UserDefaults.standard.string(forKey: "username"){
            LBL_welcome.isHidden = false
            TF_insertName.isHidden = true
            LBL_welcome.text = "Hi \(value)"
        }else{
            LBL_welcome.isHidden = true
            TF_insertName.isHidden = false
        }
    }
    
    func setName(text : String) {
        UserDefaults.standard.set(text, forKey: "username")
        TF_insertName.isHidden = true
        LBL_welcome.text = "Hi \(text)"
        LBL_welcome.isHidden = false
    }
    
    @IBAction func startGame(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        let secondController = storyboard.instantiateViewController(withIdentifier: "GameView")
        self.present(secondController, animated: true,completion: nil)
    }
}
