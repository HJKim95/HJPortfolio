//
//  StickyHeaderCell.swift
//  HJPortfolio
//
//  Created by 김희중 on 2020/09/17.
//  Copyright © 2020 HJ. All rights reserved.
//

import UIKit

class StickyHeaderCell: UICollectionViewCell {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
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
        backgroundColor = .cyan
        addSubview(headerLabel)
        
        headerLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }
}

class StickyCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLayouts() {
        backgroundColor = .lightGray
    }
}
