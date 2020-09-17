//
//  TImbreCEll.swift
//  HJPortfolio
//
//  Created by 김희중 on 2020/09/17.
//  Copyright © 2020 HJ. All rights reserved.
//

import UIKit

class TimbreCell: UICollectionViewCell {
    
    var imageViewCenterYConstraint: NSLayoutConstraint?
    
    var parallaxOffset: CGFloat = 0 {
        didSet {

        }
    }
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let imsiImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imsiImageViewConstraint: NSLayoutConstraint?
    
    fileprivate func setupLayouts() {
        addSubview(imsiImageView)
        
        imsiImageViewConstraint = imsiImageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0).first
    }
    
    func updateParallaxOffset(collectionViewBounds bounds: CGRect) {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let offsetFromCenter = CGPoint(x: center.x - self.center.x, y: center.y - self.center.y)
        let maxVerticalOffset = (bounds.height / 2) + (self.bounds.height / 2)
        let scaleFactor = 40 / maxVerticalOffset
        parallaxOffset = -offsetFromCenter.y * scaleFactor
    }
    
}
