//
//  LoginViewController.swift
//  Pokemon Assessment
//
//  Created by Hamza Rafique Azad on 25/11/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let userData = Utility.shared.getUserDetails()
        
        usernameTextField.text = userData.0
        emailTextField.text = userData.1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }


    @IBAction func loginBtnPressed(_ sender: UIButton) {
        
        guard let userName = usernameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        
        if userName.isEmpty || email.isEmpty || !(Utility.shared.isValidEmail(email: email)) {
            return
        }
        
        Utility.shared.saveUserDetails(userName: userName, email: email)
        self.tabBarController?.selectedIndex = 1
//        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.UIViewControllers.homeViewController) as! HomeViewController
//        self.navigationController?.pushViewController(homeVC, animated: true)
    }
}

