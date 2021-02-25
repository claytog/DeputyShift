//
//  ViewController.swift
//  DeputyShift
//
//  Created by Clayton on 24/2/21.
//

import UIKit

class ShiftListViewController: UIViewController {

    @IBOutlet var shiftTableView: UITableView!
    
    private var shiftList: ShiftList?
    private var httpClient = HTTPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        shiftTableView.delegate = self
        shiftTableView.dataSource = self
        
        shiftTableView.register(UINib(nibName: "ShiftCell", bundle: nil), forCellReuseIdentifier: "ShiftCell")
        
        shiftTableView.tableFooterView = UIView()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        getShiftList()
        
    }
    
    func getShiftList(){
        
        httpClient.getShifts { result in
            switch result {
            case .success(let details):
                DispatchQueue.main.async {
                    self.shiftList = details
                    self.shiftTableView.reloadData()
                //    self.loadingState = .success
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                 //   self.loadingState = .failed
                }
            }
        }
    }
    
    
    @IBAction func didPressAdd(_ sender: Any) {
        performSegue(withIdentifier: "ShiftSegue", sender: nil)
    }
    
}
extension ShiftListViewController : UITableViewDelegate,  UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shiftList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShiftCell", for: indexPath) as! ShiftCell
 
        if let shift = shiftList?[indexPath.row] {
            if let imageURL = shift.image {
                cell.img.setImageFromUrl(ImageURL: imageURL)
            }
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM y hh:mm a"
            
            let toFormatter = DateFormatter()
            toFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"
            
            if let start = shift.start {
                if let date = toFormatter.date(from: start) {
                    cell.startLabel.text = formatter.string(from: date)
                }
            }
            if let end = shift.end {
                if let date = toFormatter.date(from: end) {
                    cell.endLabel.text = formatter.string(from: date)
                }else{
                    cell.endLabel.text = ""
                }
            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 75
    }
    
}

