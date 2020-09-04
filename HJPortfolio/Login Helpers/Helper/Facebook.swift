//
//  File.swift
//  FacebookLoginTest
//
//  Created by 김희중 on 2020/07/07.
//  Copyright © 2020 HJ. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

public class Facebook {
    func getFacebookInfo(profImageSize: CGSize, completed: @escaping (_ userInfo:FacebookModel) -> Void) {
        Profile.loadCurrentProfile { (profile, error) in
            if error != nil {
                print("loading profile error ", error ?? "")
            }
            let userInfo = FacebookModel()
            guard let name = profile?.name else {return}
            guard let profileImageURL = profile?.imageURL(forMode: Profile.PictureMode.square, size: CGSize(width: profImageSize.width, height: profImageSize.height)) else {return}
            guard let userID = profile?.userID else {return}
            
            userInfo.name = name
            userInfo.profile_image_url = profileImageURL
            userInfo.id = userID
            
            completed(userInfo)
        }

    }
}
