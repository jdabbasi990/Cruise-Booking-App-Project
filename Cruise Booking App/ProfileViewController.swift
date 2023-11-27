//
//  ProfileViewController.swift
//  Cruise Booking App
//
//  Created by Jawwad Abbasi on 2023-11-27.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var fullNameTextEdit: CustomTextField!
    @IBOutlet weak var emailTextEdit: CustomTextField!
    @IBOutlet weak var passwordTextEdit: CustomTextField!
    @IBOutlet weak var phoneTextEdit: CustomTextField!
    @IBOutlet weak var countryTextEdit: CustomTextField!
    @IBOutlet weak var userNameTextEdit: CustomTextField!
    @IBOutlet weak var addressTextEdit: UITextField!
    
    var customer: Customer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Set up UI with customer details
        setupUI()
    }
    
    func setupUI() {
        guard let customer = customer else {
            return
        }

        fullNameTextEdit.text = customer.fullName
        emailTextEdit.text = customer.email
        passwordTextEdit.text = customer.password
        phoneTextEdit.text = customer.number
        countryTextEdit.text = customer.country
        userNameTextEdit.text = customer.userName
        addressTextEdit.text = customer.address
    }
    
    @IBAction func onUpdateTapped(_ sender: Any) {
        guard let customer = customer else {
            return
        }

        // Update the customer object with the new values from text fields
        customer.fullName = fullNameTextEdit.text
        customer.email = emailTextEdit.text
        customer.password = passwordTextEdit.text
        customer.number = phoneTextEdit.text
        customer.country = countryTextEdit.text
        customer.userName = userNameTextEdit.text
        customer.address = addressTextEdit.text

        // Update the customer in the database
        let customerDBManager = CustomerDBManager()
        customerDBManager.update(customer: customer)

        // Show a success message
        showAlert(message: "User details updated successfully.")
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    

}
