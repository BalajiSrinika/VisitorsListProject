//
//  VistorsListVC.swift
//  VisitorsListProject
//
//  Created by Balaji Pandian on 04/08/20.
//  Copyright © 2020 Balaji Pandian. All rights reserved.
//

import UIKit
import FirebaseFirestore


class VistorsListVC: UIViewController {
    
   @IBOutlet weak var tableview: UITableView!
    
   @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var visitorsViewModelObj : VisitorViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initilize ViewModel
        visitorsViewModelObj = VisitorViewModel()
        visitorsViewModelObj.vc = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.setDefaults()
    }
    
   fileprivate func setDefaults(){
        self.title = "Visitors List"
        self.tableview.tableFooterView = UIView()
        self.tableview.separatorStyle = .none
        self.fetchResults()
        
    }
    
    fileprivate func fetchResults(){
        self.visitorsViewModelObj.fetchRequest()
    }
 
}

extension VistorsListVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.visitorsViewModelObj.vistorsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VistorsCell") as! VistorsCell
        let list = visitorsViewModelObj.vistorsList[indexPath.row]
        cell.visistorsNameLbl.text = list.name
        cell.purposeLbl.text = list.purposeVisit
        cell.timelbl.text = "  \(list.timeStamp ?? "")   "
        if let imgUrl = list.vistorImg{
            let imageConv = visitorsViewModelObj.ConvertUrlToImg(img: imgUrl)
            cell.img.image = imageConv
        }
    
        return cell
    }
}


class VistorsCell: UITableViewCell {
    
    @IBOutlet weak var visistorsNameLbl : UILabel!
    @IBOutlet weak var purposeLbl : UILabel!
    @IBOutlet weak var timelbl : UILabel!
    @IBOutlet weak var img:UIImageView!
    
}


