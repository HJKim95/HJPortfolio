//
//  LoginController.swift
//  HJPortfolio
//
//  Created by 김희중 on 2020/09/04.
//  Copyright © 2020 HJ. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let buttonid = "buttonid"
    let bannerid = "bannerid"
    
    lazy var loginCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        loginCollectionView.register(buttonLoginCell.self, forCellWithReuseIdentifier: buttonid)
        loginCollectionView.register(bannerLoginCell.self, forCellWithReuseIdentifier: bannerid)
        
        setupLayouts()
    }
    
    var loginCollectionViewConstraint: NSLayoutConstraint?
    
    fileprivate func setupLayouts() {
        view.addSubview(loginCollectionView)
        
        if #available(iOS 11.0, *) {
            loginCollectionViewConstraint = loginCollectionView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0).first
        }
        else {
            loginCollectionViewConstraint = loginCollectionView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0).first
        }
        
    }
    
    
    //MARK:- UIcollectionviewDelegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: buttonid, for: indexPath) as! buttonLoginCell
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bannerid, for: indexPath) as! bannerLoginCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: collectionView.frame.width, height: 140)
        }
        else {
            return CGSize(width: collectionView.frame.width, height: 400)
        }
    }
}

class buttonLoginCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login Buttons"
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var kakaoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "kakao")
        iv.isUserInteractionEnabled = true
//        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loginKakao)))
        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return iv
    }()
    
    lazy var naverImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "naver")
        iv.isUserInteractionEnabled = true
        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return iv
    }()
    
    lazy var facebookImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "facebook")
        iv.isUserInteractionEnabled = true
        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return iv
    }()
    
    lazy var appleImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "apple")
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
    var buttonStackViewConstraint: NSLayoutConstraint?
    
    fileprivate func setupLayouts() {
        backgroundColor = .white

        buttonStackView.addArrangedSubview(kakaoImageView)
        buttonStackView.addArrangedSubview(naverImageView)
        buttonStackView.addArrangedSubview(facebookImageView)
        buttonStackView.addArrangedSubview(appleImageView)

        addSubview(titleLabel)
        addSubview(buttonStackView)
        
        titleLabelConstraint = titleLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30).first
        buttonStackViewConstraint = buttonStackView.anchor(titleLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 30, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 50).first
        
    }
}

class bannerLoginCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login Banners"
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let kakaoLoginButton: KOLoginButton = {
        let button = KOLoginButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginKakao), for: .touchUpInside)
        return button
    }()
    
    lazy var naverImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.isUserInteractionEnabled = true
        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return iv
    }()
    
    lazy var facebookImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .green
        iv.isUserInteractionEnabled = true
        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return iv
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
    var kakaoLoginButtonConstraint: NSLayoutConstraint?
    var buttonStackViewConstraint: NSLayoutConstraint?
    
    fileprivate func setupLayouts() {
        backgroundColor = .white

        
//        buttonStackView.addArrangedSubview(kakaoImageView)
//        buttonStackView.addArrangedSubview(naverImageView)
//        buttonStackView.addArrangedSubview(facebookImageView)
//        buttonStackView.addArrangedSubview(appleImageView)
//
        addSubview(titleLabel)
        addSubview(kakaoLoginButton)
//        addSubview(buttonStackView)
//
        titleLabelConstraint = titleLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30).first
        kakaoLoginButtonConstraint = kakaoLoginButton.anchor(titleLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 30, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 40).first
//        buttonStackViewConstraint = buttonStackView.anchor(titleLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 30, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 50).first
        
    }
    
    @objc func loginKakao() {
//        let user = Kakao()
//        user.age_range = true
//        user.birthday = true
//        user.birthyear = true
//        user.gender = true
//        user.phone_number = true
//        user.getUserInfo { [weak self] (kakao) in
//            print("--------------------------------")
//            print(kakao.age_range)
//            print(kakao.birthday)
//            print(kakao.email)
//        }
    }
}
