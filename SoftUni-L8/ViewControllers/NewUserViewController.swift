//
//  NewUserViewController.swift
//  SoftUni-L8
//
//  Created by Martin Kuvandzhiev on 20.10.21.
//

import UIKit

class NewUserViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    @IBOutlet weak var genderSegmentControl: UISegmentedControl!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var selectedGender: User.Gender {
        switch genderSegmentControl.selectedSegmentIndex {
        case 0:
            return .male
        case 1:
            return .female
        default:
            return .unknown
        }
    }
    
    func validateAndSaveData() {
        
        let birthDate = self.birthDatePicker.date
        let gender = self.selectedGender
        
        guard let firstName = self.firstNameTextField.text,
              let lastName = self.lastNameTextField.text,
              let height = Double(self.heightTextField.text ?? ""),
              let weight = Double(self.weightTextField.text ?? "") else {
                  //Show error to the user
//                  let hud = JGProgressHUD()
//                  hud.textLabel.text = "Invalid values"
//                  hud.indicatorView = JGProgressHUDErrorIndicatorView()
//                  hud.show(in: self.view)
//                  hud.dismiss(afterDelay: 3.0)
                  return
              }
        
        DispatchQueue.main.async {
            let user = User()
            user.firstName = firstName
            user.lastName = lastName
            user.eBirthDate = birthDate
            user.eGender = gender
            user.height = height
            user.weight = weight
            
            LocalDataManager.realm.beginWrite()
            LocalDataManager.realm.add(user)
            try? LocalDataManager.realm.commitWrite()
            
            RequestManager.uploadUser(user: user) { error in
                
            }
            
            NotificationCenter.default.post(name: .userDataLoaded, object: nil)
            self.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        self.validateAndSaveData()
    }
    
}
