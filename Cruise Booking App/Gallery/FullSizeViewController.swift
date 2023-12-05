// FullSizeViewController.swift

import UIKit

class FullSizeViewController: UIViewController {

    var fullSizeImage: UIImage?

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        // Add the image view to the view hierarchy
        view.addSubview(imageView)
        
        // Add the close button to the view hierarchy
        view.addSubview(closeButton)

        setupConstraints()
        
        // Print the fullSizeImage value
        print("Full Size Image: \(fullSizeImage)")

        // Set the full-size image
        imageView.image = fullSizeImage
    }

    @objc private func closeButtonTapped() {
        // Dismiss the view controller when the close button is tapped
        dismiss(animated: true, completion: nil)
    }

    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Image view constraints
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        // Close button constraints
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}
