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
        
        vc.showSpinner(onView: vc.view)
        let visitorName = vc.vistorsTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let purposeOfVisit = vc.purposeTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let timeStamp = FirebaseFirestore.Timestamp.init(date: Date())
        let img = vc.temp
        
        if visitorName == ""{
            vc.removeSpinner()
            showAlert(message: "Vistor name is empty")
        }else if purposeOfVisit == ""{
            vc.removeSpinner()
            showAlert(message: "purpose of visit is empty")
        }else if img == "" {
            vc.removeSpinner()
            showAlert(message: "please Upload Image")
        }else{
            db.collection("VistorsList").addDocument(data: ["Vistorname":visitorName, "purpose":purposeOfVisit,"image": img ,"date": timeStamp]) { (error) in
                
                if error != nil {
                    print("Error saving user data \(error?.localizedDescription ?? "")")
                }
            }
            
            vc.removeSpinner()
            _ = vc.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func uploadImage(){
        
        vc.showSpinner(onView: vc.view)
        
        let storageRef = Storage.storage().reference()
        let value = String(Date().millisecondsSince1970)
        let storedImage = storageRef.child(value)
        
        if let uploadData = vc.profImg.jpegData(compressionQuality: 1)
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
                        self.vc.removeSpinner()
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
