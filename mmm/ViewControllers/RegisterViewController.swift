//////
//  LoginViewController.swift
//  CustomLoginDemo
//
//  Created by Christopher Ching on 2019-07-22.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var homeHoodTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
   
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    
    func setUpElements() {
        
        // Hide the error label
        errorLabel.alpha = 0
        
        // Style the elements
//        Utilities.styleTextField(emailTextField)
//        Utilities.styleTextField(passwordTextField)
//        Utilities.styleFilledButton(registerButton)
        
    }
    
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            homeHoodTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    

    @IBAction func signUpTapped(_ sender: Any) {
        
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            
            // There's something wrong with the fields, show error message
            showError(error!)
        }
        else {
            
            // Create cleaned versions of the data
            let name = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let homeHood = homeHoodTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                // Check for errors
                if err != nil {
                    
                    // There was an error creating the user
                    self.showError("Error creating user")
                }
                else {
                    
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["name":name, "home hood":homeHood, "uid": result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            // Show error message
                            self.showError("Error saving user data")
                        }
                    }
                    
                    // Transition to the home screen
                    self.transitionToHome()
                }
                
            }
            
            
            
        }
    }
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
}


////  RegisterViewController.swift
////  mmm
////
////  Created by AM Devito on 2022-01-12.
////
//
//import UIKit
//
//class RegisterViewController: UIViewController {
//
//
//    @IBOutlet weak var nameTextField: UITextField!
//
//    @IBOutlet weak var homeHoodTextField: UITextField!
//
//    @IBOutlet weak var emailTextField: UITextField!
//
//    @IBOutlet weak var passwordTextField: UITextField!
//
//    @IBOutlet weak var registerButton: UIButton!
//
//    @IBOutlet weak var errorLabel: UILabel!
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        setUpElements()
//    }
//
//    func setUpElements(){
//        errorLabel.alpha = 0
//    }
//
//    //Check the fields and validate that the data is correct. If verything is correct, this method returns nil. Otherwise, it returns the errormessage
//    func validateFields() -> String? {
//        //check that all fields are filled in
//        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  homeHoodTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || {
//
//            return "Please fill in all fields."
//        }
//
//        return nil
//    }
//
//    @IBAction func registerTapped(_ sender: Any) {
//
//        //Validate the fields
//
//        //Create the user
//
//        //transition to the home screen
//    }
//}
//
