//
//  ResultViewController.swift
//  Cruise Booking App
//
//  Created by Jawwad Abbasi on 2023-12-05.
//

import UIKit

class ResultViewController: UIViewController {
    
    
    @IBOutlet weak var nameLBLReuslt: UILabel!
    
    
    @IBOutlet weak var emailLBLReuslt: UILabel!
    
    
    @IBOutlet weak var phoneLBLReuslt: UILabel!
    
    
    @IBOutlet weak var addressLBLReuslt: UILabel!
    
    
    @IBOutlet weak var peopleLBLReuslt: UILabel!
    
    
    @IBOutlet weak var packageLBLReuslt: UILabel!
    
    
    @IBOutlet weak var dateLBLReuslt: UILabel!
    
    
    @IBOutlet weak var cruiseLBLReuslt: UILabel!
    
    @IBOutlet weak var totalLBLReuslt: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Retrieve the last booking from the database
        if let lastBooking = CustomerDBManager().getLastBooking() {
            // Update UI elements with booking details
            nameLBLReuslt.text = "Full Name: \(String(describing: lastBooking.customerName))"
            emailLBLReuslt.text = lastBooking.customerEmail
            phoneLBLReuslt.text = lastBooking.customerPhone
            addressLBLReuslt.text = lastBooking.customerAddress

            // Calculate the total number of people
            let totalPeople = lastBooking.numberOfAdults + lastBooking.numberOfMinors + lastBooking.numberOfSeniors
            peopleLBLReuslt.text = "Number of people: \(totalPeople)"

            // Set the cruise package
            let package: String
            switch lastBooking.cruisePackage {
            case 0:
                package = "Silver"
            case 1:
                package = "Gold"
            case 2:
                package = "Diamond"
            default:
                package = "Unknown"
            }
            packageLBLReuslt.text = "Package: \(package)"

            // Set the departure date
            dateLBLReuslt.text = "Departure Date: \(lastBooking.departureDate)"

            // Calculate and set the total amount
            let packagePrice: Double
            switch lastBooking.cruisePackage {
            case 0:
                packagePrice = 1000
            case 1:
                packagePrice = 1500
            case 2:
                packagePrice = 2000
            default:
                packagePrice = 0
            }
            let totalAmount = Double(totalPeople) * packagePrice
            totalLBLReuslt.text = "Total Amount: $\(totalAmount)"
        }
    }   
}






