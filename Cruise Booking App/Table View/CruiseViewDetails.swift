//
//  CruiseViewDetails.swift
//  Cruise Booking App
//
//  Created by Jawwad Abbasi on 2023-12-09.
//

import UIKit
import SafariServices

class CruiseViewDetails: UIViewController {
    
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    
    @IBOutlet weak var details: UILabel!
    
    
    @IBOutlet weak var ratings: UIImageView!
    
    var selectedCruise : Cruise!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        name.text = selectedCruise.id + " - " + selectedCruise.name
        image.image = UIImage(named: selectedCruise.imageName)
        details.text = selectedCruise.details
        ratings.image = UIImage(named: selectedCruise.ratings)
    }
    
    @IBAction func onTappedWebView(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string:"https://www.apple.com")!)
        
        present(vc, animated: true)
        
    }
    

    
}
