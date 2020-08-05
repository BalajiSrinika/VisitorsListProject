//
//  VisistorViewModel.swift
//  VisitorsListProject
//
//  Created by Balaji Pandian on 04/08/20.
//  Copyright © 2020 Balaji Pandian. All rights reserved.
//

import Foundation
import FirebaseFirestore


class VisitorViewModel {
    
    weak var vc : VistorsListVC!
    
    var vistorsList = [Vistors]()
       
    func fetchRequest() {
        
        vc.activityIndicator.startAnimating()
        self.vc.activityIndicator.hidesWhenStopped = true
        
        vistorsList.removeAll()
        
        
        let db = Firestore.firestore()
        
        db.collection("VistorsList").getDocuments() { (querySnapshot, err) in
           
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for (_,document) in querySnapshot!.documents.enumerated() {
                    
                    //print("\(document.documentID) => \(document.data())")
                    
                    let vistorData = document.data()
                    let visistorName = vistorData["Vistorname"] as? String
                    let purposeOfVisit = vistorData["purpose"] as? String
                    let visitorImg = vistorData["image"] as? String
                    
                    guard let ts = vistorData["date"] as? Timestamp else {
                        return
                    }
                    let stampDate = ts.dateValue()
                    let dateString = self.ConvertDateToString(date:stampDate)
                    
                    self.vistorsList.append(Vistors(name: visistorName, purposeVisit: purposeOfVisit, vistorImg: visitorImg, timeStamp: dateString))
                  
                    self.vistorsList = self.vistorsList.sorted(by: {
                    $0.timeStamp!.compare($1.timeStamp!) == .orderedAscending
                   })
                    
                }
                
                DispatchQueue.main.async {
                    self.vc.tableview.reloadData()
                    self.vc.activityIndicator.stopAnimating()
                    self.vc.activityIndicator.hidesWhenStopped = true
                }
            }
        }
    }
    
    func ConvertDateToString(date:Date) -> String{
          let df = DateFormatter()
          df.dateFormat = "dd-MM-yyyy hh:mm a"
          let dateString = df.string(from: date)
          return dateString
      }
      
      func ConvertUrlToImg(img:String) -> UIImage{
          
          var image = UIImage()
          let url = URL(string: img)
          let data = try? Data(contentsOf: url!)
          if let imageData = data {
              image = UIImage(data: imageData)!
          }
          return image
      }
       
}
