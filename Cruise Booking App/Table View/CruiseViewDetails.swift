//
//  CruiseViewDetails.swift
//  Cruise Booking App
//
//  Created by Jawwad Abbasi on 2023-12-09.
//

import UIKit

class CruiseViewDetails: UIViewController {
    
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    var selectedCruise : Cruise!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        name.text = selectedCruise.id + " - " + selectedCruise.name
        image.image = UIImage(named: selectedCruise.imageName)
    }
    

}
