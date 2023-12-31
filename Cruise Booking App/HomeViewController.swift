//
//  ViewController.swift
//  Cruise Booking App
//
//  Created by Jawwad Abbasi on 2023-11-15.
//

import UIKit

class HomeViewController: UIViewController {
    let backgroundImageView = UIImageView()


    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()// seting background image
        // Do any additional setup after loading the view.
    }
    
    

 
    
    
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

