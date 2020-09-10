//
//  categoryCell.swift
//  HJPortfolio
//
//  Created by 김희중 on 2020/09/10.
//  Copyright © 2020 HJ. All rights reserved.
//

import UIKit

class categoryCell: UICollectionViewCell {
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        return label
    }()
    
    let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var categoryLabelConstraint: NSLayoutConstraint?
    var dividerLineConstraint: NSLayoutConstraint?
    
    fileprivate func setupLayouts() {
        backgroundColor = .white
        addSubview(categoryLabel)
        addSubview(dividerLine)
        
        categoryLabelConstraint = categoryLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0).first
        dividerLineConstraint = dividerLine.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0.5, rightConstant: 10, widthConstant: 0, heightConstant: 0.5).first
    }
    
    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor = isHighlighted ? UIColor(red: 209, green: 209, blue: 214) : .white
            categoryLabel.backgroundColor = isHighlighted ? UIColor(red: 209, green: 209, blue: 214) : .white
        }
    }

    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? UIColor(red: 209, green: 209, blue: 214) : .white
            categoryLabel.backgroundColor = isSelected ? UIColor(red: 209, green: 209, blue: 214) : .white
        }
    }
}
