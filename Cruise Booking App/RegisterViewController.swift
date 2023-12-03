//
//  RegisterViewController.swift
//  Cruise Booking App
//
//  Created by Jawwad Abbasi on 2023-11-26.
//
import SQLite3
import UIKit

class RegisterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let backgroundImageView = UIImageView()
    let countries = ["USA", "Canada", "Brazil", "Mexico", "Argentina"]

    @IBOutlet weak var fullNameTextEdit: CustomTextField!
    @IBOutlet weak var emailTextEdit: CustomTextField!
    @IBOutlet weak var passwordTextEdit: CustomTextField!
    @IBOutlet weak var phoneTextEdit: CustomTextField!
    @IBOutlet weak var countryTextEdit: CustomTextField!
    @IBOutlet weak var userNameTextEdit: CustomTextField!
    @IBOutlet weak var addressTextEdit: CustomTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()

        // Do any additional setup after loading the view.
        // Set up UIPickerView for countryTextEdit
        countryTextEdit.inputView = createPickerView()
        countryTextEdit.inputAccessoryView = createToolbar()
    }


    
    @IBAction func registerButtonTapped(_ sender: Any) {
        guard let fullName = fullNameTextEdit.text, !fullName.isEmpty,
              let email = emailTextEdit.text, !email.isEmpty,
              let password = passwordTextEdit.text, !password.isEmpty,
              let phone = phoneTextEdit.text, !phone.isEmpty,
              let country = countryTextEdit.text, !country.isEmpty,
              let userName = userNameTextEdit.text, !userName.isEmpty,
              let address = addressTextEdit.text, !address.isEmpty else {
            showAlert(message: "Please fill in all fields.")
            return
        }

        // Assuming you have initialized CustomerDBManager somewhere in your class
        let customerDBManager = CustomerDBManager()

        // Create a Customer object without setting the ID
        let customer = Customer(id: 0, fullName: fullName, email: email, password: password, number: phone, country: country, userName: userName, address: address)

        // Insert the customer into the database
        customerDBManager.insert(customer: customer)

        // Show a success message
        showAlert(message: "User has been added successfully.") {
            // Perform segue when OK button is pressed
            self.performSegue(withIdentifier: "ProfileScreen", sender: customer)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProfileScreen" {
            if let destinationVC = segue.destination as? ProfileViewController,
               let customer = sender as? Customer {
                destinationVC.customer = customer
            }
        }
    }

    func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Setting wallpaper background
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

    // MARK: - UIPickerView

    func createPickerView() -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }

    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDoneButton))
        toolbar.setItems([doneButton], animated: false)

        return toolbar
    }

    @objc func handleDoneButton() {
        countryTextEdit.resignFirstResponder()
    }

    // MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryTextEdit.text = countries[row]
    }
}
