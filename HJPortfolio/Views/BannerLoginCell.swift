//
//  bannerLoginCell.swift
//  HJPortfolio
//
//  Created by 김희중 on 2020/09/04.
//  Copyright © 2020 HJ. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import AuthenticationServices

class BannerLoginCell: UICollectionViewCell {
    
    var delegate: LoginController?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login Banners"
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        return label
    }()
    
    lazy var logoutLabel: UILabel = {
        let label = UILabel()
        label.text = "LOGOUT"
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.backgroundColor = .red
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.alpha = 0
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logOut)))
        return label
    }()
    
    lazy var kakaoLoginButton: KOLoginButton = {
        let button = KOLoginButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginKakao), for: .touchUpInside)
        return button
    }()
    
    lazy var naverBannerContainerView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loginNaver)))
        view.backgroundColor = UIColor(hex: 0x1EC800)
        return view
    }()
    
    let naverImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "naver")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let naverLoginLabel: UILabel = {
        let label = UILabel()
        label.text = "네이버 아이디로 로그인"
        label.font = UIFont.boldSystemFont(ofSize: 16)
//        label.font = "나눔바른고딕 Bold"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor(hex: 0x1EC800)
        return label
    }()
    
    let facebookLoginButton: FBLoginButton = {
        let fb = FBLoginButton()
        fb.permissions = ["public_profile", "email"]
        return fb
    }()
//
//    lazy var facebookImageView: UIImageView = {
//        let iv = UIImageView()
//        iv.backgroundColor = .green
//        iv.isUserInteractionEnabled = true
//        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        iv.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        return iv
//    }()
//
    
    lazy var appleLoginButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton()
        button.addTarget(self, action: #selector(loginApple), for: .touchUpInside)
        return button
    }()
    lazy var appleImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .brown
        iv.isUserInteractionEnabled = true
        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return iv
    }()
    
    let buttonStackView: UIStackView = {
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var titleLabelConstraint: NSLayoutConstraint?
    var logoutLabelConstraint: NSLayoutConstraint?
    var kakaoLoginButtonConstraint: NSLayoutConstraint?
    var naverBannerContainerViewConstraint: NSLayoutConstraint?
    var naverImageViewConstraint: NSLayoutConstraint?
    var naverLoginLabelConstraint: NSLayoutConstraint?
    var facebookLoginButtonConstraint: NSLayoutConstraint?
    var appleLoginButtonConstraint: NSLayoutConstraint?
    
    fileprivate func setupLayouts() {
        backgroundColor = .white

        addSubview(titleLabel)
        addSubview(logoutLabel)
        addSubview(kakaoLoginButton)
        addSubview(naverBannerContainerView)
        naverBannerContainerView.addSubview(naverImageView)
        naverBannerContainerView.addSubview(naverLoginLabel)
        addSubview(facebookLoginButton)
        addSubview(appleLoginButton)

        titleLabelConstraint = titleLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 200, heightConstant: 30).first
        logoutLabelConstraint = logoutLabel.anchor(self.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 100, heightConstant: 30).first
        kakaoLoginButtonConstraint = kakaoLoginButton.anchor(titleLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 30, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 40).first
        naverBannerContainerViewConstraint = naverBannerContainerView.anchor(kakaoLoginButton.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 20, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 40).first
        naverImageViewConstraint = naverImageView.anchor(naverBannerContainerView.topAnchor, left: naverBannerContainerView.leftAnchor, bottom: naverBannerContainerView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 0).first
        naverLoginLabelConstraint = naverLoginLabel.anchor(naverBannerContainerView.topAnchor, left: naverImageView.rightAnchor, bottom: naverBannerContainerView.bottomAnchor, right: naverBannerContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0).first
        facebookLoginButtonConstraint = facebookLoginButton.anchor(naverBannerContainerView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 20, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 0).first
        appleLoginButtonConstraint = appleLoginButton.anchor(facebookLoginButton.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 20, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 40).first
    }
    
    @objc fileprivate func loginKakao() {
        delegate?.loginKakao()
    }
    
    @objc fileprivate func loginNaver() {
        delegate?.loginNaver()
    }
    
    @objc fileprivate func loginApple() {
        delegate?.loginApple()
    }
    
    @objc fileprivate func logOut() {
        delegate?.logout()
    }
    
}
