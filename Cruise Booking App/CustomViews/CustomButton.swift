//
//  CustomButton.swift
//  Project-Cruise-App
//
//  Created by Jawwad Abbasi on 2023-10-28.
//
// Team Members [ Jawwad(301298052), Habib(301279481) , and Muskan(301399676)]
// Milestone Number 2
// Submission date: OCT 30 2023

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    private func setupButton() {
           backgroundColor = Colors.woodBrown
           titleLabel?.font = UIFont(name: "MuktaMahee", size: 32) // Change the font to MuktaMahee and set the font size to 32
           layer.cornerRadius = frame.size.height / 2
           setTitleColor(.white, for: .normal)
       }

}
