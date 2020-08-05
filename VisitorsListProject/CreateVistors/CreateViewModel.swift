//
//  CreateViewModel.swift
//  VisitorsListProject
//
//  Created by Balaji Pandian on 04/08/20.
//  Copyright © 2020 Balaji Pandian. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage


class CreateViewModel {
    
    weak var vc : CreateVistorsViewController!
    
    
    func createVistor(){
        
        let db = Firestore.firestore()
        
        let visitorName = vc.vistorsTF.text ?? ""
        let purposeOfVisit = vc.purposeTF.text ?? ""
        
        let timeStamp = FirebaseFirestore.Timestamp.init(date: Date())
        let img = vc.temp
        
        if visitorName == ""{
            showAlert(message: "Please enter Visitor Name")
        }else if purposeOfVisit == ""{
            showAlert(message: "Please enter the purpose of visiting")
        }else if img == "" {
            showAlert(message: "Please upload photos and proceed")
        }else{
             vc.activityIndicator.startAnimating()
            self.vc.activityIndicator.hidesWhenStopped = false
            self.vc.activityIndicator.hidesWhenStopped = false
            db.collection("VistorsList").addDocument(data: ["Vistorname":visitorName, "purpose":purposeOfVisit,"image": img ,"date": timeStamp]) { (error) in
                
                if error != nil {
                    print("Error saving user data \(error?.localizedDescription ?? "")")
                }
            }
            
            self.vc.activityIndicator.stopAnimating()
            self.vc.activityIndicator.hidesWhenStopped = true
            _ = vc.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func uploadImage(){
        
        self.vc.activityIndicator.startAnimating()
        self.vc.activityIndicator.hidesWhenStopped = false
        
        
        let storageRef = Storage.storage().reference()
        let value = String(Date().millisecondsSince1970)
        let storedImage = storageRef.child(value)
        
        if let uploadData = vc.profImg.jpegData(compressionQuality: 0.5)
        {
            
            vc.addImgBut.setTitle("", for: .normal)
            
            storedImage.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                
                if error != nil {
                    print(error?.localizedDescription ?? "")
                }
                storedImage.downloadURL(completion: { (url, error) in
                    
                    if error != nil {
                        print(error?.localizedDescription ?? "")
                    }
                    
                    if let urlText = url?.absoluteString {
                        print(urlText)
                        self.vc.temp = urlText
                        self.vc.activityIndicator.stopAnimating()
                        self.vc.activityIndicator.hidesWhenStopped = true
                    }
                })
            })
        }
        
    }
    
    func showAlert(message:String){
        let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
            print("warning!!")
        }))
        
        vc.present(alert, animated: true, completion: nil)
    }
    
    
}
