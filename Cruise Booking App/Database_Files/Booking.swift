// Booking.swift

import Foundation

class Booking {
    var id: Int
    var customerName: String?
    var customerEmail: String?
    var customerPhone: String?
    var customerAddress: String?
    var numberOfAdults: Int
    var numberOfMinors: Int
    var numberOfSeniors: Int
    var cruisePackage: Int
    var departureDate: String
    var selectedCruise: String?  // Added property for the selected cruise


    init(id: Int, customerName: String?, customerEmail: String?, customerPhone: String?, customerAddress: String?, numberOfAdults: Int, numberOfMinors: Int, numberOfSeniors: Int, cruisePackage: Int, departureDate: String, selectedCruise: String?) {
        self.id = id
        self.customerName = customerName
        self.customerEmail = customerEmail
        self.customerPhone = customerPhone
        self.customerAddress = customerAddress
        self.numberOfAdults = numberOfAdults
        self.numberOfMinors = numberOfMinors
        self.numberOfSeniors = numberOfSeniors
        self.cruisePackage = cruisePackage
        self.departureDate = departureDate
        self.selectedCruise = selectedCruise

    }
}
