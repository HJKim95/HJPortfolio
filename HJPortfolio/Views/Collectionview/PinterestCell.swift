//
//  PinterestCell.swift
//  HJPortfolio
//
//  Created by 김희중 on 2020/09/17.
//  Copyright © 2020 HJ. All rights reserved.
//

import UIKit

class PinterestCell: UICollectionViewCell {
    
    let pintImage: UIImageView = {
        let iv = UIImageView()
        
        return iv
    }()
    
    let pintAnnotation: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLayouts() {
        addSubview(pintImage)
        addSubview(pintAnnotation)
        
    }
    
    var pintImageConstraint: NSLayoutConstraint?
    var pintAnnotationConstraint: NSLayoutConstraint?
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        pintImageConstraint = pintImage.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0).first
        pintAnnotationConstraint = pintAnnotation.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 60).first
    }
}

class pintHeaderCell: UICollectionViewCell {
    
    let pintHeaderImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .cyan
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLayouts() {
        backgroundColor = .lightGray
        addSubview(pintHeaderImage)
        
    }
    
    var pintHeaderImageConstraint: NSLayoutConstraint?
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
//        let attributes = layoutAttributes as! PinterestLayoutAttributes
//        let imageHeight = attributes.imageHeight
//        attributes.headerDeltaY
        pintHeaderImageConstraint = pintHeaderImage.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0).first
    }
}
