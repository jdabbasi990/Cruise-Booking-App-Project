// PhotoCollectionViewCell.swift

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotoCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true // Enable user interaction for tap gesture
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupImageView()
        addTapGesture()
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let images = [
            UIImage(named: "thumbnail_1"),
            UIImage(named: "thumbnail_2"),
            UIImage(named: "thumbnail_3"),
            UIImage(named: "thumbnail_4"),
            UIImage(named: "thumbnail_5"),
            UIImage(named: "thumbnail_6"),
        ].compactMap({ $0 })
        imageView.image = images.randomElement()
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func imageTapped() {
        // Notify the delegate (your view controller) that the image was tapped
        delegate?.photoCellDidTapImage(self)
    }
    
    // Delegate to handle the tap event
    weak var delegate: PhotoCollectionViewCellDelegate?
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        imageView.image = nil
    }
}

// Protocol for delegate
protocol PhotoCollectionViewCellDelegate: AnyObject {
    func photoCellDidTapImage(_ cell: PhotoCollectionViewCell)
}
