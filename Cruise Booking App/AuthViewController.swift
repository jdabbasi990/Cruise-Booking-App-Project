//
//  AuthViewController.swift
//  Cruise Booking App
//
//  Created by Jawwad Abbasi on 2023-11-26.
//

import UIKit

class AuthViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: CustomTextField!
    
    @IBOutlet weak var passwordTextField: CustomTextField!
    
    let backgroundImageView = UIImageView()


    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()

        emailTextField.delegate = self
        passwordTextField.delegate = self
        


    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField did begin editing")
        // Additional code if needed
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    
    @IBAction func OnLoginButton(_ sender: Any) {
        // Check entered credentials
        let enteredEmail = emailTextField.text ?? ""
        let enteredPassword = passwordTextField.text ?? ""

        if enteredEmail == "test@gmail.com" && enteredPassword == "test123" {
            // Credentials are correct, show login successful popup
            showLoginSuccessfulPopup()
        } else {
            // Credentials are incorrect, show an error message or handle it as needed
            print("Incorrect credentials")
            showIncorrectCredentialsAlert()
        }
    }

    func showLoginSuccessfulPopup() {
        let alertController = UIAlertController(title: "Login Successful", message: "Welcome!", preferredStyle: .alert)

        // Add an action to dismiss the alert
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Handle any additional actions after login success
        }
        alertController.addAction(okAction)

        // Present the alert
        present(alertController, animated: true, completion: nil)
    }

    func showIncorrectCredentialsAlert() {
        let alertController = UIAlertController(title: "Incorrect Credentials", message: "Please check your email and password.", preferredStyle: .alert)

        // Add an action to dismiss the alert
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)

        // Present the alert
        present(alertController, animated: true, completion: nil)
    }

    func setBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        backgroundImageView.image = UIImage(named: "teal_background3")
        view.sendSubviewToBack(backgroundImageView)
    }

}
