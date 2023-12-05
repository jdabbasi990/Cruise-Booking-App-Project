//
//  PaymentViewController.swift
//  Cruise Booking App
//
//  Created by Jawwad Abbasi on 2023-12-04.
//

import UIKit

class PaymentViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var cardTypeField: CustomTextField!
    @IBOutlet weak var cardNameField: CustomTextField!
    @IBOutlet weak var cardNumberField: CustomTextField!
    @IBOutlet weak var cardExpiryField: CustomTextField!
    @IBOutlet weak var cardCVVField: CustomTextField!
    var booking: Booking?

    
    let cardTypes = ["VISA", "MASTER"]
    var cardTypePickerView = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the picker view for cardTypeField
        cardTypePickerView.delegate = self
        cardTypePickerView.dataSource = self
        cardTypeField.inputView = cardTypePickerView
        
        // Add a toolbar with a Done button to close the picker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePicker))
        toolbar.setItems([doneButton], animated: true)
        cardTypeField.inputAccessoryView = toolbar
    }
    
    // UIPickerViewDataSource methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cardTypes.count
    }

    // UIPickerViewDelegate method
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cardTypes[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cardTypeField.text = cardTypes[row]
    }

    @objc func donePicker() {
        view.endEditing(true)
    }

    @IBAction func onPaymentClicked(_ sender: Any) {
        // Validate fields
        guard let cardType = cardTypeField.text, !cardType.isEmpty else {
            showAlert(message: "Please select a card type.")
            return
        }

        guard let cardName = cardNameField.text, !cardName.isEmpty else {
            showAlert(message: "Please enter the cardholder's name.")
            return
        }

        guard let cardNumber = cardNumberField.text, cardNumber.count == 16 else {
            showAlert(message: "Please enter a valid 16-digit card number.")
            return
        }

        guard let expiryDate = cardExpiryField.text, isValidExpiryDate(expiryDate) else {
            showAlert(message: "Please enter a valid expiry date in the format MM/YY.")
            return
        }

        guard let cvv = cardCVVField.text, cvv.count == 3 else {
            showAlert(message: "Please enter a valid 3-digit CVV.")
            return
        }

        // If all validations pass, show the confirmation alert
        showConfirmationAlert()
        
    }

    // Helper function to show a confirmation alert
    func showConfirmationAlert() {
        let alertController = UIAlertController(title: "Confirmation", message: "Are you sure to proceed?", preferredStyle: .alert)
        
        // OK action
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Perform segue to ResultViewController
            self.performSegue(withIdentifier: "ResultScreen", sender: self)
        }
        
        // Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    // Helper function to show an alert popup
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    // Helper function to validate expiry date
    func isValidExpiryDate(_ expiryDate: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        if let date = dateFormatter.date(from: expiryDate), date >= Date() {
            return true
        } else {
            return false
        }
    }
}
