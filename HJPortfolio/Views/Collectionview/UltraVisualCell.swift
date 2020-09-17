//
//  UltraVisualCell.swift
//  HJPortfolio
//
//  Created by 김희중 on 2020/09/17.
//  Copyright © 2020 HJ. All rights reserved.
//

import UIKit
import HJLayout

class UltraVisualCell: UICollectionViewCell {
    
    let coverView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.3
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var coverViewConstraint: NSLayoutConstraint?
    
    fileprivate func setupLayouts() {
        addSubview(coverView)
        
        coverViewConstraint = coverView.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0).first
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        let featuredHeight = UltravisualLayoutConstants.Cell.featuredHeight
        let standardHeight = UltravisualLayoutConstants.Cell.standardHeight
        
        // featured --> delta: 1 --> minAlpha
        // standard --> delta: 0 --> maxAlpha
        let delta = 1 - ((featuredHeight - frame.height) / (featuredHeight - standardHeight))

        let minAlpha: CGFloat = 0.3
        let maxAlpha: CGFloat = 0.75
        // alpha가 1에 가까울수록 어두운것..
        coverView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
    }
}

