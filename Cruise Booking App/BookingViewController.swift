//
//  BookingViewController.swift
//  Cruise Booking App
//
//  Created by Jawwad Abbasi on 2023-12-03.
//

import UIKit

class BookingViewController: UIViewController {
    
    
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
    
    // Prices for each cruise package
    let silverPrice: Double = 1000
    let goldPrice: Double = 1500
    let diamondPrice: Double = 2000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSteppers()

        // Do any additional setup after loading the view.
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
    

    @IBAction func onBookingClicked(_ sender: Any) {
        
        let booking = Booking(
            id: 0, // You may need to set the correct ID based on your logic
            customerName: nameBookField.text,
            customerEmail: emailBookingField.text,
            customerPhone: phoneBookingField.text,
            customerAddress: addressBookingField.text,
            numberOfAdults: Int(adultStepper.value),
            numberOfMinors: Int(minorStepper.value),
            numberOfSeniors: Int(sineorsStepper.value),
            cruisePackage: cruisePackageSegment.selectedSegmentIndex,
            departureDate: departureDatePicker.date.description
        )

        // Assuming you have an instance of CustomerDBManager
        let dbManager = CustomerDBManager()
        dbManager.insertBooking(booking: booking)
        
    }
    

}
