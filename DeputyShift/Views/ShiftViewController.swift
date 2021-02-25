//
//  ShiftViewController.swift
//  DeputyShift
//
//  Created by Clayton on 25/2/21.
//

import Foundation

import UIKit

class ShiftViewController: UIViewController {
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var shiftTime: UIDatePicker!
    @IBOutlet var shiftTypeSegmented: UISegmentedControl!
    @IBOutlet var actInd: UIActivityIndicatorView!
    
    private var httpClient = HTTPClient()
    
    @IBAction func didPressSave(_ sender: Any) {
        actInd.isHidden = false
        actInd.startAnimating()
        let postShift: ShiftPost = ShiftPost()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"
        
        postShift.time = formatter.string(from: shiftTime.date)
       
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
        
    }
   
}
