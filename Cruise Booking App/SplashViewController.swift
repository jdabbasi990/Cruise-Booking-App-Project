//
//  SplashViewController.swift
//  Cruise Booking App
//
//  Created by Jawwad Abbasi on 2023-11-15.
//

import UIKit
import AVFoundation

class SplashViewController: UIViewController {
    let backgroundImageView = UIImageView()

    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var shipWheel: UIImageView!
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        
        
        // Rotate the ship wheel for 2 seconds and play sound
        UIView.animate(withDuration: 2.5, animations: {
            // Rotate the ship wheel
            self.shipWheel.transform = CGAffineTransform(rotationAngle: .pi)
            
            // Calling the sound function
            self.playSound()
            
            // Fade in the loading label
            self.loadingLabel.alpha = 1.0
        }) { _ in
            // After the rotation using Segue, redirect to the Home VC
            self.performSegue(withIdentifier: "HomeWelcome", sender: nil)
        }
        
        // Start animating dots in the loading label
        animateLabel()
    }
    
    func playSound() {
        if let soundURL = Bundle.main.url(forResource: "gear2", withExtension: "mp3") {
            print("Sound URL: \(soundURL)")
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        } else {
            print("Sound file not found.")
        }
    }
    
    func animateLabel() {
        // Get the screen size
        let screenSize = UIScreen.main.bounds.size
        
        // Set the initial position of the label outside the screen to the left
        loadingLabel.frame.origin.x = -screenSize.width
        
        // Animate the label from left to right over 2 seconds
        UIView.animate(withDuration: 2.0, delay: 0, options: [], animations: {
            self.loadingLabel.frame.origin.x = 0
        }, completion: nil)
    }
    func setBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        backgroundImageView.image = UIImage(named: "teal_background1")
        view.sendSubviewToBack(backgroundImageView)
    }

}
