//
//  BookingViewController.swift
//  Cruise Booking App
//
//  Created by Jawwad Abbasi on 2023-12-03.
//

import UIKit

class BookingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var cruisePicker: CustomTextField!
    @IBOutlet weak var nameBookField: CustomTextField!
    @IBOutlet weak var emailBookingField: CustomTextField!
    @IBOutlet weak var phoneBookingField: CustomTextField!
    @IBOutlet weak var addressBookingField: CustomTextField!
    @IBOutlet weak var adultStepper: UIStepper!
    @IBOutlet weak var adultStepperlabel: UILabel!
    @IBOutlet weak var minorStepper: UIStepper!
    @IBOutlet weak var minorStepperLabel: UILabel!
    @IBOutlet weak var sineorsStepper: UIStepper!
    @IBOutlet weak var sineorsStepperLabel: UILabel!
    @IBOutlet weak var cruisePackageSegment: UISegmentedControl!
    @IBOutlet weak var departureDatePicker: UIDatePicker!
    var booking: Booking?


    let silverPrice: Double = 1000
    let goldPrice: Double = 1500
    let diamondPrice: Double = 2000
    let cruiseOptions = ["Bahamas", "Star", "Coral Reef", "Blue Mist", "Sea Queen"]
    var cruisePickerView = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSteppers()
        setupPicker()
    }

    private func setupSteppers() {
        adultStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        minorStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        sineorsStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        cruisePackageSegment.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }

    @objc private func stepperValueChanged(_ sender: UIStepper) {
        // Update corresponding labels based on the stepper value
        if sender == adultStepper {
            adultStepperlabel.text = "\(Int(adultStepper.value))"
        } else if sender == minorStepper {
            minorStepperLabel.text = "\(Int(minorStepper.value))"
        } else if sender == sineorsStepper {
            sineorsStepperLabel.text = "\(Int(sineorsStepper.value))"
        }

        // Update the total cost whenever the stepper values change
        updateTotalCost()
    }

    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        // Update the total cost whenever the segmented control value changes
        updateTotalCost()
    }

    private func updateTotalCost() {
        let numberOfAdults = Int(adultStepper.value)
        let numberOfMinors = Int(minorStepper.value)
        let numberOfSeniors = Int(sineorsStepper.value)

        var selectedPackagePrice: Double = 0

        switch cruisePackageSegment.selectedSegmentIndex {
        case 0:
            selectedPackagePrice = silverPrice
        case 1:
            selectedPackagePrice = goldPrice
        case 2:
            selectedPackagePrice = diamondPrice
        default:
            break
        }

        let totalCost = (Double(numberOfAdults) + Double(numberOfMinors) + Double(numberOfSeniors)) * selectedPackagePrice

        print("Total Cost: $\(totalCost)")
    }

    private func setupPicker() {
        cruisePickerView.delegate = self
        cruisePickerView.dataSource = self
        cruisePicker.inputView = cruisePickerView

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePicker))
        toolbar.setItems([doneButton], animated: true)
        cruisePicker.inputAccessoryView = toolbar
    }

    @objc func donePicker() {
        view.endEditing(true)
    }

    // UIPickerViewDataSource methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cruiseOptions.count
    }

    // UIPickerViewDelegate method
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cruiseOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cruisePicker.text = cruiseOptions[row]
    }

    @IBAction func onBookingClicked(_ sender: Any) {
        guard let selectedCruise = cruisePicker.text, !selectedCruise.isEmpty else {
            showAlert(message: "Please select a cruise.")
            return
        }

        let booking = Booking(
            id: 0,
            customerName: nameBookField.text,
            customerEmail: emailBookingField.text,
            customerPhone: phoneBookingField.text,
            customerAddress: addressBookingField.text,
            numberOfAdults: Int(adultStepper.value),
            numberOfMinors: Int(minorStepper.value),
            numberOfSeniors: Int(sineorsStepper.value),
            cruisePackage: cruisePackageSegment.selectedSegmentIndex,
            departureDate: departureDatePicker.date.description,
            selectedCruise: selectedCruise // Added property for the selected cruise

        )

        // Assuming you have an instance of CustomerDBManager
        let dbManager = CustomerDBManager()
        dbManager.insertBooking(booking: booking)
        // Show the success popup
        showSuccessPopup(message: "Booking added successfully!")
        
    }

    func showSuccessPopup(message: String) {
        let alertController = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Perform the segue to PaymentViewController
            self.performSegue(withIdentifier: "PayScreen", sender: self)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
