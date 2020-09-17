//
//  TransformingCell.swift
//  HJPortfolio
//
//  Created by 김희중 on 2020/09/17.
//  Copyright © 2020 HJ. All rights reserved.
//

import UIKit

class TransformingCell: UICollectionViewCell {
    let imsiImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
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
        addSubview(imsiImage)
        imsiImage.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }
    
}

class selectLayoutCell: UICollectionViewCell {
    let imsiLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        return label
    }()
    
    let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    let checkImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "check")
        iv.alpha = 0
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
        addSubview(imsiLabel)
        addSubview(dividerLine)
        addSubview(checkImage)
        
        imsiLabel.frame = CGRect(x: 12, y: 0, width: frame.width - 12, height: frame.height - 10)
        dividerLine.frame = CGRect(x: 20, y: frame.height - 1, width: frame.width - 40, height: 0.5)
        checkImage.frame = CGRect(x: frame.width - 42, y: 0, width: 30, height: 30)
    }
    
    override var isHighlighted: Bool {
        didSet {
            checkImage.alpha = isHighlighted ? 1 : 0
        }
    }
    
    override var isSelected: Bool {
        didSet {
            checkImage.alpha = isSelected ? 1 : 0
        }
    }
}
