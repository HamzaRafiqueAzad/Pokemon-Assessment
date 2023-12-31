//
//  Utility.swift
//  Pokemon Assessment
//
//  Created by Hamza Rafique Azad on 25/11/23.
//

import Foundation
import Alamofire

class Utility {
    static let shared = Utility()
    
    func isValidEmail(email: String) -> Bool {
        // Regular expression for a simple email format
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
        
    func saveUserDetails(userName: String, email: String) {
        UserDefaults.standard.setValue(userName, forKey: Constants.UserDetails.userName)
        UserDefaults.standard.setValue(email, forKey: Constants.UserDetails.email)
    }
    
    func getUserDetails() -> (String, String) {
        let userName = UserDefaults.standard.value(forKey: Constants.UserDetails.userName) as? String ?? ""
        let email = UserDefaults.standard.value(forKey: Constants.UserDetails.email) as? String ?? ""
        
        return (userName, email)
    }
    
    func callApiWithCompletion(url: String, completionBlock: @escaping ([String:Any]?,String?) -> Void) {
        
        AF.request(url, method: .get).responseJSON { (response) in
            if let error = response.error {
                completionBlock(nil, NSLocalizedString("Something Went Wrong. Please Try Again.", comment: ""))
            }
            else{
                if let result = response.value as? [String:Any] {
                    completionBlock(result,nil)
                }
                else{
                    completionBlock(nil, NSLocalizedString("Something Went Wrong. Please Try Again.", comment: ""))
                }
            }
        }
        
    }
    
}
