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
    private var activityView = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
        
        httpClient.getShifts { result in
            switch result {
            case .success(let details):
                DispatchQueue.main.async {
                    self.shiftList = details
                    self.shiftTableView.reloadData()
                    self.activityView.stopAnimating()
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.activityView.stopAnimating()
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
                if cell.imgView.image == nil {
                    cell.imgView.setImageFromUrl(ImageURL: imageURL)
                }
            }
            
            if let start = shift.start {
                if let date = Util.shared.formatStringToDate(dateStr: start, dateType: .long) {
                    cell.startLabel.text = Util.shared.formatDateToString(date: date, dateType: .medium)
                }
            }
            if let end = shift.end {
                if let date = Util.shared.formatStringToDate(dateStr: end, dateType: .long) {
                    cell.endLabel.text = Util.shared.formatDateToString(date: date, dateType: .medium)
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

