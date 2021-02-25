//
//  ShiftViewController.swift
//  DeputyShift
//
//  Created by Clayton on 25/2/21.
//

import Foundation

import UIKit
import CoreLocation

class ShiftViewController: UIViewController {
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var shiftTime: UIDatePicker!
    @IBOutlet var shiftTypeSegmented: UISegmentedControl!
    @IBOutlet var actInd: UIActivityIndicatorView!
    
    @IBOutlet var latLabel: UILabel!
    @IBOutlet var longLabel: UILabel!
    
    private var httpClient = HTTPClient()
    private var locationManager = CLLocationManager()
    
    @IBAction func didPressSave(_ sender: Any) {
        actInd.isHidden = false
        actInd.startAnimating()
        let postShift: ShiftPost = ShiftPost()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"
        
        postShift.time = formatter.string(from: shiftTime.date)
        postShift.latitude = latLabel.text
        postShift.longitude = longLabel.text
       
        var shiftType: ShiftType = .start
        if shiftTypeSegmented.selectedSegmentIndex == 1 {
            shiftType = .end
        }
        
        httpClient.postShift(shift: postShift, shiftType: shiftType , completion: { result in
            print(result)
            
            switch result {
            case .success(let details):
                DispatchQueue.main.async {
                    self.messageLabel.text = details
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.messageLabel.text = error.localizedDescription
                }
            }
            DispatchQueue.main.async {
                self.actInd.stopAnimating()
                self.actInd.isHidden = true
            }
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageLabel.text = ""
        self.actInd.isHidden = true
        self.latLabel.text = "0.00000"
        self.longLabel.text = "0.00000"
        
        getCurrentLocation()
    }
   
}

extension ShiftViewController : CLLocationManagerDelegate {
    
    func getCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                self.latLabel.text = String(format: "%.5f", location.coordinate.latitude)
                self.longLabel.text = String(format: "%.5f", location.coordinate.longitude)
            }
        }
    
}
