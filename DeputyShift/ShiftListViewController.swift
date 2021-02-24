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

}
extension ShiftListViewController : UITableViewDelegate,  UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shiftList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShiftCell", for: indexPath) as! ShiftCell
                cell.backgroundColor = UIColor.lightGray
                return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 70
    }
    
}

