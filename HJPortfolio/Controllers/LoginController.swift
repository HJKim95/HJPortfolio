//
//  LoginController.swift
//  HJPortfolio
//
//  Created by 김희중 on 2020/09/04.
//  Copyright © 2020 HJ. All rights reserved.
//

import UIKit
import NaverThirdPartyLogin
import FBSDKLoginKit
import AuthenticationServices

class LoginController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let buttonid = "buttonid"
    let bannerid = "bannerid"
    let resultid = "resultid"
    
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
        
        loginCollectionView.register(ButtonLoginCell.self, forCellWithReuseIdentifier: buttonid)
        loginCollectionView.register(BannerLoginCell.self, forCellWithReuseIdentifier: bannerid)
        loginCollectionView.register(LoginResultCell.self, forCellWithReuseIdentifier: resultid)
        
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: buttonid, for: indexPath) as! ButtonLoginCell
            cell.delegate = self
            return cell
        }
        else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bannerid, for: indexPath) as! BannerLoginCell
            cell.delegate = self
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resultid, for: indexPath) as! LoginResultCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: collectionView.frame.width, height: 140)
        }
        else if indexPath.item == 1{
            return CGSize(width: collectionView.frame.width, height: 330)
        }
        else {
            return CGSize(width: collectionView.frame.width, height: 300)
        }
    }
    
    //MARK:- Login Functions
    //Kakao
    func loginKakao() {
        print("kakao login button clicked")
        let user = Kakao()
        user.age_range = true
        user.birthday = true
        user.birthyear = true
        user.gender = true
        user.phone_number = true
        user.getUserInfo { [weak self] (kakao) in
            print("--------------------------------")
            print(kakao.age_range)
            print(kakao.birthday)
            print(kakao.email)
        }
    }
    
    //Naver
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    func loginNaver() {
        print("naver login button clicked")
        loginInstance?.delegate = self
        
        loginInstance?.requestThirdPartyLogin()
    }
    
    func logoutNaver() {
        print("log out!")
        loginInstance?.requestDeleteToken()
    }
    
    var keyArray = ["연령대: ","생일: ","이메일: ","성별: ","id: ","이름: ","별명: ", "프로필이미지url: "]
    var userInfoArray = [String]()
    
    //Facebook
    func loginFacebook() {
        LoginManager().logIn(permissions: ["email" , "public_profile"], from: self) {
            (result, err) in
            if err != nil {
                print("Custom FB Login Failed", err ?? "")
                return
            }
            if result != nil {
                let facebook = Facebook()
                facebook.getFacebookInfo(profImageSize: CGSize(width: 100, height: 100)) { (info) in
                    print(info.id)
                    print(info.name)
                    print(info.profile_image_url)
                }
            }
        }

    }
    
    func logoutFacebook() {
        LoginManager().logOut()
    }
    
    func loginApple() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
}

extension LoginController: NaverThirdPartyLoginConnectionDelegate {
    // 로그인에 성공했을 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("[Success] : Success Naver Login")
        let naver = Naver()
        naver.getNaverInfo { [weak self] (naver) in
            self?.userInfoArray.removeAll()
            self?.userInfoArray.append(naver.age_range!)
            self?.userInfoArray.append(naver.birthday!)
            self?.userInfoArray.append(naver.email!)
            self?.userInfoArray.append(naver.gender!)
            self?.userInfoArray.append(naver.id!)
            self?.userInfoArray.append(naver.name!)
            self?.userInfoArray.append(naver.nickname!)
            self?.userInfoArray.append(naver.profile_image_url!)
            
//            self?.naverCollectionview.reloadData()
        }
    }
    
    // 접근 토큰 갱신
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print("이미 로그인 되어 있습니다.")
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        loginInstance?.requestDeleteToken()
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("[Error] :", error.localizedDescription)
    }
}

extension LoginController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = credential.user
            let fullName = credential.fullName
            let email = credential.email
            print(userIdentifier, fullName, email, separator: "\n")
            UserDefaults.standard.set(userIdentifier, forKey: "appleUserId")
        }
    }
}

