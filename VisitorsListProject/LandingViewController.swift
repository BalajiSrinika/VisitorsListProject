//
//  ViewController.swift
//  VisitorsListProject
//
//  Created by Balaji Pandian on 04/08/20.
//  Copyright © 2020 Balaji Pandian. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class LandingViewController: UIViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = Firestore.firestore()
        
        db.collection("VistorsList").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let sam = document.data()
                    let vn = sam["Vistorname"]
                    let purp = sam["purpose"]
                }
                
            }
        }
        
    }
    
    @IBAction func dateSaveToFirebase(){
        
    }
    
}
