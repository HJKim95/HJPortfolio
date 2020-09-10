//
//  bigCategoryCell.swift
//  HJPortfolio
//
//  Created by 김희중 on 2020/09/10.
//  Copyright © 2020 HJ. All rights reserved.
//

import UIKit

class bigCategoryCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellid = "cellid"
    
    var delegate: MainController?
    
    var indexTag = 0
    
    var categories = [String]()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .darkGray
        return label
    }()
    
    lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var categoryLabelConstraint: NSLayoutConstraint?
    var categoryCollectionViewConstraint: NSLayoutConstraint?
    
    fileprivate func setupLayouts() {
        backgroundColor = .collectionviewBackColor
        addSubview(categoryLabel)
        addSubview(categoryCollectionView)
        
        categoryLabelConstraint = categoryLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 10, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20).first
        categoryCollectionViewConstraint = categoryCollectionView.anchor(categoryLabel.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0).first
        
        categoryCollectionView.register(categoryCell.self, forCellWithReuseIdentifier: cellid)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! categoryCell
        cell.categoryLabel.text = categories[indexPath.item]
        if indexPath.item == categories.count - 1 {
            cell.dividerLine.alpha = 0
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controllerName = categories[indexPath.item]
        delegate?.pushController(controller: controllerName, tag: indexTag, index: indexPath.item)
    }
    
}
