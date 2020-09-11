//
//  WeatherBannerView.swift
//  HJPortfolio
//
//  Created by 김희중 on 2020/09/10.
//  Copyright © 2020 HJ. All rights reserved.
//

import UIKit
import HJWeather

class WeatherBannerCell: UICollectionViewCell {
    
    var delegate: MainController?
    
    
    var weatherInfo = [String:String]() {
        didSet {
            guard let imageString = weatherInfo["weatherImage"] else {return}
            guard let tempString = weatherInfo["weatherTemp"] else {return}
            guard let skyString = weatherInfo["weatherSky"] else {return}
            weatherImageView.image = UIImage(named: imageString)
            weatherLabel.text = "\(tempString)°C"
            
        }
    }
    
    var dustAttributedString =  NSMutableAttributedString(string: "") {
        didSet {
            dustLabel.attributedText = dustAttributedString
            dustLabel.sizeToFit()
        }
    }
    
    var locationString = "" {
        didSet {
            locationLabel.text = locationString
        }
    }
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .darkGray
        label.backgroundColor = .collectionviewBackColor
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let weatherImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let weatherLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 26)
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    let compareLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.text = "   어제보다 3°C 낮아요."
        return label
    }()
    
    let dustLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    lazy var updateImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "refresh")
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(updateLocation)))
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var categoryLabelConstraint: NSLayoutConstraint?
    var containerViewConstraint: NSLayoutConstraint?
    var weatherImageViewConstraint: NSLayoutConstraint?
    var weatherLabelConstraint: NSLayoutConstraint?
    var locationLabelConstraint: NSLayoutConstraint?
    var compareLabelConstraint: NSLayoutConstraint?
    var dustLabelConstraint: NSLayoutConstraint?
    var dividerLineConstraint: NSLayoutConstraint?
    var updateImageViewConstraint: NSLayoutConstraint?
    
    fileprivate func setupLayouts() {
        backgroundColor = .collectionviewBackColor
        
        addSubview(categoryLabel)
        
        addSubview(containerView)
        containerView.addSubview(weatherImageView)
        containerView.addSubview(weatherLabel)
        containerView.addSubview(locationLabel)
        containerView.addSubview(compareLabel)
        containerView.addSubview(dustLabel)
        containerView.addSubview(dividerLine)
        containerView.addSubview(updateImageView)
        
        
        categoryLabelConstraint = categoryLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 10, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20).first
        containerViewConstraint = containerView.anchor(categoryLabel.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0).first
        dustLabelConstraint = dustLabel.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30).first
        weatherImageViewConstraint = weatherImageView.anchor(categoryLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 12, bottomConstant: 5, rightConstant: 0, widthConstant: 62, heightConstant: 62).first
        weatherLabelConstraint = weatherLabel.anchor(categoryLabel.bottomAnchor, left: weatherImageView.rightAnchor, bottom: dustLabel.topAnchor, right: nil, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 70, heightConstant: 0).first
        updateImageViewConstraint = updateImageView.anchor(locationLabel.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 25, heightConstant: 25).first
        locationLabelConstraint = locationLabel.anchor(categoryLabel.bottomAnchor, left: weatherLabel.rightAnchor, bottom: nil, right: updateImageView.leftAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30).first
        compareLabelConstraint = compareLabel.anchor(locationLabel.bottomAnchor, left: weatherLabel.rightAnchor, bottom: dustLabel.topAnchor, right: updateImageView.leftAnchor, topConstant: -10, leftConstant: 0, bottomConstant: 0.5, rightConstant: 0, widthConstant: 0, heightConstant: 0).first
        dividerLineConstraint = dividerLine.anchor(compareLabel.bottomAnchor, left: self.leftAnchor, bottom: dustLabel.topAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 0.5).first
        
        
    }
    
    @objc fileprivate func updateLocation() {
        rotate()
        delegate?.updateLocation()
    }
    
    fileprivate func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 0.8
        rotation.isCumulative = true
        rotation.repeatCount = 2
        updateImageView.layer.add(rotation, forKey: "rotationAnimation")
    }
    
}
