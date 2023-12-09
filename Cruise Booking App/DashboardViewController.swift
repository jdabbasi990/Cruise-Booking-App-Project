//
//  DashboardViewController.swift
//  Cruise Booking App
//
//  Created by Jawwad Abbasi on 2023-11-16.
//

import UIKit

class DashboardViewController: UIViewController {
    let backgroundImageView = UIImageView()

    @IBOutlet weak var btnGallery: UIButton!
    
    @IBOutlet weak var btnBooking: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()


        // Do any additional setup after loading the view.
    }
    
    @IBAction func onGalleryClick(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "Gallery") as! GalleryViewController

        controller.title = "Gallery"
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
    @IBAction func onBookingClicked(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "Booking") as! BookingViewController

        controller.title = "Booking"
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
    @IBAction func onDetailsClicked(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "Details") as! SearchCruiseViewController

        controller.title = "Cruise Details"
        self.navigationController?.pushViewController(controller, animated: true)
        
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
}
