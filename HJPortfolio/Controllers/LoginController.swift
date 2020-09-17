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
    
    var userdefault = UserDefaults.standard
    //Naver login instance
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    let buttonid = "buttonid"
    let bannerid = "bannerid"
    let resultid = "resultid"
    
    lazy var backImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "back")
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goBack)))
        return iv
    }()
    
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
    
    var backImageViewConstraint: NSLayoutConstraint?
    var loginCollectionViewConstraint: NSLayoutConstraint?
    
    fileprivate func setupLayouts() {
        view.addSubview(backImageView)
        view.addSubview(loginCollectionView)
        
        if #available(iOS 11.0, *) {
            backImageViewConstraint = backImageView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 24, leftConstant: 24, bottomConstant: 0, rightConstant: 0, widthConstant: 24, heightConstant: 24).first
            loginCollectionViewConstraint = loginCollectionView.anchor(backImageView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0).first
        }
        else {
            backImageViewConstraint = backImageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 24, leftConstant: 24, bottomConstant: 0, rightConstant: 0, widthConstant: 24, heightConstant: 24).first
            loginCollectionViewConstraint = loginCollectionView.anchor(backImageView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0).first
        }
        
    }
    
    @objc fileprivate func goBack() {
        self.navigationController?.popViewController(animated: true)
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
            cell.delegate = self
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
            return CGSize(width: collectionView.frame.width, height: 200)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkLogin()
    }
    
    //MARK:- Login Functions
    
    var currentUserInfo = [String:String]()
    
    func checkLogin() {
        print("--checking login infos--")
        if let info = userdefault.dictionary(forKey: "LoginInfo") {
            let name = info["name"] as? String ?? ""
            let email = info["email"] as? String ?? ""
            let sns = info["sns"] as? String ?? ""
            
            refreshLoginInfo(name: name, email: email, sns: sns, login: true)
        }
    }
    
    fileprivate func refreshLoginInfo(name: String, email: String, sns: String, login: Bool) {
        let indexPath = IndexPath(item: 2, section: 0)
        let cell = loginCollectionView.cellForItem(at: indexPath) as! LoginResultCell
        let index = IndexPath(item: 1, section: 0)
        let bannerCell = loginCollectionView.cellForItem(at: index) as! BannerLoginCell
        
        
        cell.nameLabel.text = "Name: \(name)"
        cell.emailLabel.text = "Email: \(email)"
        cell.loginNameLabel.text = "SNS: \(sns)"
        
        if login {
            cell.statusLabel.text = "Connected"
            cell.statusLabel.textColor = .green
            cell.loginNameLabel.textColor = .green
            
            bannerCell.logoutLabel.alpha = 1
            
            let loginInfo: [String: String] = ["name": name, "email": email, "sns": sns]
            userdefault.set(loginInfo, forKey: "LoginInfo")
            
            currentUserInfo = loginInfo
        }
        else {
            cell.statusLabel.text = "Not connected"
            cell.statusLabel.textColor = .red
            cell.loginNameLabel.textColor = .red
            
            bannerCell.logoutLabel.alpha = 0
        }

        loginCollectionView.reloadData()

    }
    
    func logout() {
        let sns = currentUserInfo["sns"] ?? ""
        
        switch sns {
        case "Kakao":
            createAlert(title: "\(sns) Logout", message: "로그아웃 합니다.", open: false)
            logoutKakao()
        case "Naver":
            createAlert(title: "\(sns) Logout", message: "로그아웃 합니다.", open: false)
            logoutNaver()
        case "Facebook":
            createAlert(title: "\(sns) Logout", message: "로그아웃 합니다.", open: false)
            logoutFacebook()
        case "Apple":
            createAlert(title: "\(sns) Logout ERROR", message: "설정창에서 apple id 사용 앱 사용중단해주세요.", open: true)
        default:
            break
        }
        userdefault.removeObject(forKey: "LoginInfo")
        currentUserInfo.removeAll()
        refreshLoginInfo(name: "", email: "", sns: "", login: false)
        
    }
    
    
//MARK:- Kakao Login
    func loginKakao() {
        if currentUserInfo["sns"] == "Kakao" {
            self.createAlert(title: "이미 로그인되어 있습니다.", message: "", open: false)
        }
        else {
            if currentUserInfo.count > 0 {
                let sns = currentUserInfo["sns"] ?? ""
                self.createAlert(title: "\(sns) 로그아웃을 먼저 해주세요.", message: "", open: false)
            }
            else {
                let user = Kakao()
                user.age_range = true
                user.birthday = true
                user.birthyear = true
                user.gender = true
                user.phone_number = true
                user.getUserInfo { [weak self] (kakao) in
                    guard let name = kakao.nickname else {return}
                    guard let email = kakao.email else {return}
                    
                    self?.refreshLoginInfo(name: name, email: email, sns: "Kakao", login: true)
                }
            }
        }
    }
    
    func logoutKakao() {
        guard let session = KOSession.shared() else { return }
        session.logoutAndClose { (success, error) in
            if success {
                print("logout kakao successed.")
                self.dismiss(animated: true, completion: nil)
            }
            else {
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
//MARK:- Facebook Login
    func loginFacebook() {
        if currentUserInfo["sns"] == "Facebook" {
            self.createAlert(title: "이미 로그인되어 있습니다.", message: "", open: false)
        }
        else {
            if currentUserInfo.count > 0 {
                let sns = currentUserInfo["sns"] ?? ""
                self.createAlert(title: "\(sns) 로그아웃을 먼저 해주세요.", message: "", open: false)
            }
            else {
                LoginManager().logIn(permissions: ["email" , "public_profile"], from: self) {
                    (result, err) in
                    if err != nil {
                        print("Custom FB Login Failed", err ?? "")
                        return
                    }
                    if result != nil {
                        let facebook = Facebook()
                        facebook.getFacebookInfo(profImageSize: CGSize(width: 100, height: 100)) { [weak self] (info) in
                            guard let name = info.name else {return}
                            guard let email = info.id else {return}
                            
                            self?.refreshLoginInfo(name: name, email: email, sns: "Facebook", login: true)
        //                    print(info.id)
        //                    print(info.name)
        //                    print(info.profile_image_url)
                        }
                    }
                }
            }
        }

    }
    
    func logoutFacebook() {
        LoginManager().logOut()
    }
    
    
    
//MARK:- Private
    func createAlert(title:String, message:String, open:Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("확인", comment: ""), style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            alert.dismiss(animated: true) {
                if open {
                    // https://stackoverflow.com/questions/28152526/how-do-i-open-phone-settings-when-a-button-is-clicked
                    UIApplication.shared.open(URL(string: "App-prefs:Apple_ID")!)
                }
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

//MARK:- Naver Login
extension LoginController: NaverThirdPartyLoginConnectionDelegate {

    func loginNaver() {
        if currentUserInfo.count > 0 {
            let sns = currentUserInfo["sns"] ?? ""
            self.createAlert(title: "\(sns) 로그아웃을 먼저 해주세요.", message: "", open: false)
        }
        else {
            loginInstance?.delegate = self
            loginInstance?.requestThirdPartyLogin()
        }
    }
    
    func logoutNaver() {
        loginInstance?.requestDeleteToken()
    }
    
    // 로그인에 성공했을 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        
        let naver = Naver()
        naver.getNaverInfo { [weak self] (naver) in
//            self?.userInfoArray.removeAll()
//            self?.userInfoArray.append(naver.age_range!)
//            self?.userInfoArray.append(naver.birthday!)
//            self?.userInfoArray.append(naver.email!)
//            self?.userInfoArray.append(naver.gender!)
//            self?.userInfoArray.append(naver.id!)
//            self?.userInfoArray.append(naver.name!)
//            self?.userInfoArray.append(naver.nickname!)
//            self?.userInfoArray.append(naver.profile_image_url!)
            guard let name = naver.name else {return}
            guard let email = naver.email else {return}
            
            self?.refreshLoginInfo(name: name, email: email, sns: "Naver", login: true)
        }
    }
    
    // 접근 토큰 갱신
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        self.createAlert(title: "이미 로그인되어 있습니다.", message: "", open: false)
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        loginInstance?.requestDeleteToken()
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("[Error] :", error.localizedDescription)
    }
}

//MARK:- Apple Login
extension LoginController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func loginApple() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let userid = userdefault.string(forKey: "appleUserId") ?? ""
        let provider = ASAuthorizationAppleIDProvider()
        if currentUserInfo["sns"] == "Apple" {
            self.createAlert(title: "이미 로그인되어 있습니다.", message: "", open: false)
        }
        else {
            if currentUserInfo.count > 0 {
                let sns = currentUserInfo["sns"] ?? ""
                self.createAlert(title: "\(sns) 로그아웃을 먼저 해주세요.", message: "", open: false)
            }
            else {
                provider.getCredentialState(forUserID: userid) { [weak self] (credentialState, error) in
                    if credentialState != .authorized {
                        let controller = ASAuthorizationController(authorizationRequests: [request])
                        controller.delegate = self
                        controller.presentationContextProvider = self
                        controller.performRequests()
                    }
                    else {
                        // UIAlert should run on main thread
                        DispatchQueue.main.async {
                            self?.createAlert(title: "Apple Login ERROR", message: "설정창에서 apple id 사용 앱 사용중단해주세요.", open: true)
                        }
                    }
                }
            }
        }
        
        
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = credential.user
            guard let fullName = credential.fullName else {return}
            let name = "\(fullName.familyName ?? "")\(fullName.givenName ?? "")"
            let email = credential.email ?? ""
            self.refreshLoginInfo(name: name, email: email, sns: "Apple", login: true)
            userdefault.set(userIdentifier, forKey: "appleUserId")
            
        }
    }
}

