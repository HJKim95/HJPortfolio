//
//  ViewController.swift
//  HJPortfolio
//
//  Created by 김희중 on 2020/09/04.
//  Copyright © 2020 HJ. All rights reserved.
//

import UIKit
import CoreLocation
import HJWeather

class MainController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate {
    
    fileprivate let cellid = "cellid"
    fileprivate let weatherid = "weatherid"
    
    var locationManager = CLLocationManager()
    
    let bigCategories = ["Logins","Weathers","Collectionview layouts", "Collectionview transforming layouts"]
    let loginCategories = ["SNS Login"]
    let layoutCategories = ["Pinterest", "Sticky Header", "Ultra Visual", "Timbre"]
    let transformingCategories = ["Transforming"]
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.text = "HeeJung's Portfolio"
        label.textColor = .black
        return label
    }()
    
    lazy var totalCategoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .collectionviewBackColor
        cv.isUserInteractionEnabled = false
        return cv
    }()
    
    var titleLabelConstraint: NSLayoutConstraint?
    var totalCategoryCollectionViewConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.setStatusBar(color1: .mainGradient_color1, color2: .mainGradient_color2) // custom extension
        
        setupLayouts()
        getLocationPermission()
        totalCategoryCollectionView.register(bigCategoryCell.self, forCellWithReuseIdentifier: cellid)
        totalCategoryCollectionView.register(WeatherBannerCell.self, forCellWithReuseIdentifier: weatherid)

    }
    
    
    fileprivate func setupLayouts() {
        view.addSubview(titleLabel)
        view.addSubview(totalCategoryCollectionView)
        
        if #available(iOS 11.0, *) {
            titleLabelConstraint = titleLabel.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50).first
        }
        else {
            titleLabelConstraint = titleLabel.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50).first
        }
        
        totalCategoryCollectionViewConstraint = totalCategoryCollectionView.anchor(titleLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0).first
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: weatherid, for: indexPath) as! WeatherBannerCell
            cell.categoryLabel.text = bigCategories[indexPath.item]
            cell.weatherInfo = weatherBannerInfo
            cell.dustAttributedString = dustAttributedString
            cell.locationString = locationText
            cell.delegate = self
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! bigCategoryCell
            cell.categoryLabel.text = bigCategories[indexPath.item]
            cell.indexTag = indexPath.item
            
            if indexPath.item == 0 {
                cell.categories = loginCategories
            }
            else if indexPath.item == 2 {
                cell.categories = layoutCategories
            }
            else if indexPath.item == 3 {
                cell.categories = transformingCategories
            }
            cell.delegate = self
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bigCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 1 {
            return CGSize(width: collectionView.frame.width, height: 130)
        }
        else {
            var counts = 0
            if indexPath.item == 0 {
                counts = loginCategories.count
            }
            else if indexPath.item == 2 {
                counts = layoutCategories.count
            }
            else if indexPath.item == 3 {
                counts = transformingCategories.count
            }
            return CGSize(width: collectionView.frame.width, height: CGFloat(counts * 40) + 38)
        }
        
    }
    
    var cellTag = 0
    var cellIndex = 0
    
    func pushController(controller: String, tag: Int, index: Int) {
        var controll = UIViewController()
        cellTag = tag
        cellIndex = index
        switch controller {
        case "SNS Login":
            controll = LoginController()
        case "Pinterest":
            controll = PinterestController()
        case "Sticky Header":
            controll = StickyHeaderController()
        case "Ultra Visual":
            controll = UltraVisualController()
        case "Timbre":
            controll = TimbreController()
        case "Transforming":
            controll = TransformingController()
        default:
            print("none of controller matched")
        }
        self.navigationController?.pushViewController(controll, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 1 {
            let weather = WeatherController()
            self.navigationController?.pushViewController(weather, animated: true)
        }
    }
    
    // deselect cell in categoryCell
    override func viewWillAppear(_ animated: Bool) {
        let indexPath = IndexPath(item: cellTag, section: 0)
        let bigCell = totalCategoryCollectionView.cellForItem(at: indexPath) as? bigCategoryCell
        let innerIndexPath = IndexPath(item: cellIndex, section: 0)
        bigCell?.categoryCollectionView.deselectItem(at: innerIndexPath, animated: false)
    }

    //MARK:- Weather function
    fileprivate func getLocationPermission() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
    }
    
    func updateLocation() {
        weatherBannerInfo.removeAll()
        dustAttributedString =  NSMutableAttributedString(string: "")
        
//        updateImageView.isUserInteractionEnabled = false
        didUpdated = false
        locationManager.startUpdatingLocation()
    }
    
    var weatherBannerInfo = [String:String]()
    
    fileprivate func getNowWeather(lat: String, long: String) {
        let date = WeatherApiHelper.shared.getDate(date: .today)
        let time = Int(WeatherApiHelper.shared.getTime())!
        var timeString = ""
        if time < 9 {
            timeString = "\(date)0\(time + 1)00"
        }
        else {
            if time == 23 {
                let tomorrow = WeatherApiHelper.shared.getDate(date: .tomorrow)
                timeString = "\(tomorrow)0000"
            }
            else {
                timeString = "\(date)\(time + 1)00"
            }
            
        }
        
        WeatherApiHelper.shared.getNowWeather(lat: lat, long: long) { [weak self] (weather) in
            if let weatherInfo = weather.totalWeatherDataStringDict {
                var imageString = ""
                
                if let rainImageString = weatherInfo[timeString]?["api_rain_image"] {
                    // 비가 올경우 비오는걸 무조건 표현하고 아닌경우 하늘 상태를 표현한다.
                    imageString = rainImageString
                }
                else {
                    if let skyImageString = weatherInfo[timeString]?["api_sky_image"] {
                        imageString = skyImageString
                    }
                }
                self?.weatherBannerInfo["weatherImage"] = imageString
                
                guard let temp = weatherInfo[timeString]?["T1H"] else {return}
                self?.weatherBannerInfo["weatherTemp"] = temp
                
                guard let sky = weatherInfo[timeString]?["SKY"] else {return}
                self?.weatherBannerInfo["weatherSky"] = sky
                self?.totalCategoryCollectionView.reloadData()
                
            }
        }
    }
    
    fileprivate func getCurrentDustData(cityName: String, subLocalName: String) {
        DustApiHelper.shared.todayDustInfo(cityName: cityName, subLocalName: subLocalName) { [weak self] (data) in
            guard let attributedString = self?.getDustData(pm10: data.dust10Value, pm10Comment: data.dustPM10Comment, pm25: data.dust25Value, pm25Comment: data.dustPM25Comment) else {return}
            self?.dustAttributedString = attributedString
            self?.totalCategoryCollectionView.reloadData()
        }
    }
    
    var dustAttributedString =  NSMutableAttributedString(string: "")
    
    fileprivate func getDustData(pm10: String, pm10Comment: String, pm25: String, pm25Comment: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "fineDust")
        imageAttachment.bounds = CGRect(x: 0, y: -2, width: 15, height: 15)
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        let dust10 = " 미세먼지  " + pm10
        attributedString.append(NSAttributedString(string: dust10))
        let dust10Comment = " " + pm10Comment + "     "
        attributedString.append(NSAttributedString(string: dust10Comment))
        let imageAttachment2 = NSTextAttachment()
        imageAttachment2.image = UIImage(named: "ultrafineDust")
        imageAttachment2.bounds = CGRect(x: 0, y: -2, width: 15, height: 15)
        attributedString.append(NSAttributedString(attachment: imageAttachment2))
        let dust25 = " 초미세먼지  " + pm25
        attributedString.append(NSAttributedString(string: dust25))
        let dust25Comment = " " + pm25Comment
        attributedString.append(NSAttributedString(string: dust25Comment))
        return attributedString
    }
    
    var didUpdated: Bool = false
    var locationText = ""
    
    //MARK: - location delegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation

        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        let lat = "\(userLocation.coordinate.latitude)"
        let long = "\(userLocation.coordinate.longitude)"
        
        if !didUpdated {
            getNowWeather(lat: lat, long: long)

            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(userLocation) { [weak self] (placemarks, error) in
                if (error != nil){
                    print("error in reverseGeocode")
                }
                let placemark = placemarks! as [CLPlacemark]
                if placemark.count > 0 {
                    let placemark = placemarks![0]
                    
                    guard let city = placemark.administrativeArea else {return}
                    guard let locality = placemark.locality else {return}
                    guard let locName = placemark.name else {return}
                    self?.locationText = "   \(locality) \(locName)"
                    self?.getCurrentDustData(cityName: city, subLocalName: locality)

                }
            }
            locationManager.stopUpdatingLocation()
            totalCategoryCollectionView.isUserInteractionEnabled = true
            didUpdated = true
        }
        
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
}


