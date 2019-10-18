//
//  Alert.swift
//  IndiaMLS
//
//  Created by admin on 02/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class Alert: NSObject {

    
    class func ShowAlert(title : String, message : String, viewcontroller: UIViewController){
        
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        viewcontroller.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
}
