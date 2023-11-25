//
//  ProfileViewController.swift
//  Pokemon Assessment
//
//  Created by Hamza Rafique Azad on 25/11/23.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let userDetails = Utility.shared.getUserDetails()
        usernameTextField.text = userDetails.0
        emailTextField.text = userDetails.1
    }
    
    
    @IBAction func saveBtnPressed(_ sender: UIButton) {
        guard let userName = usernameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        
        if userName.isEmpty || email.isEmpty || !(Utility.shared.isValidEmail(email: email)){
            return
        }
        
        Utility.shared.saveUserDetails(userName: userName, email: email)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
