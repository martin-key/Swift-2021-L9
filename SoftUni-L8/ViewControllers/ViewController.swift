//
//  ViewController.swift
//  SoftUni-L8
//
//  Created by Martin Kuvandzhiev on 13.10.21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapNextOnEmail(_ sender: Any) {
        self.passwordTextField.becomeFirstResponder()
    }
    
    @IBAction func didTapNextOnPassword(_ sender: Any) {
        self.passwordTextField.resignFirstResponder()
    }
    
    @IBAction func didTapRegister(_ sender: Any) {
        guard let email = self.emailTextField.text,
              let password = self.passwordTextField.text else {
                  return
              }
        
        
//        RequestManager.createUser(email: email,
//                                  password: password.hash.description) { error in
            let messageContent = "Success"

            let alertController = UIAlertController(title: "Registration result", message: messageContent, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                alertController.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
//        }
    }
}

