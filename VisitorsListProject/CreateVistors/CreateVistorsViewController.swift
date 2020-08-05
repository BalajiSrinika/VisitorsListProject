//
//  CreateVistorsViewController.swift
//  VisitorsListProject
//
//  Created by Balaji Pandian on 04/08/20.
//  Copyright © 2020 Balaji Pandian. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import Firebase


class CreateVistorsViewController: UIViewController {
    
    @IBOutlet weak var vistorsTF : UITextField!
    @IBOutlet weak var purposeTF : UITextField!
    @IBOutlet weak var submitBut : UIButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var addImgBut : UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var imagePicker: ImagePicker!
    var profImg = UIImage()
    var temp = String()
    var createViewModelObj : CreateViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initilize ViewModel
        createViewModelObj = CreateViewModel()
        createViewModelObj.vc = self
        setDefaults()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
      
    }
    
    func setDefaults(){
        self.title = "Visitor Details"
        self.activityIndicator.hidesWhenStopped = true
    }
    
    @IBAction func showImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    

    @IBAction func submitActn(_ sender: UIButton){
        
        self.createViewModelObj.createVistor()

    }
 
}
extension CreateVistorsViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        if let imageData = image{
            self.imageView.image = imageData
            self.profImg = imageData
            self.createViewModelObj.uploadImage()
        }
    }
    
}


extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}


