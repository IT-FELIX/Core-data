//
//  UserInfoCell.swift
//  CoreDataTrip
//
//  Created by SRS on 14/10/19.
//  Copyright © 2019 Harish Kshirsagar. All rights reserved.
//

import UIKit

class UserInfoCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imgViewUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
       self.imgViewUser.layer.borderColor = UIColor.brown.cgColor
       self.imgViewUser.layer.borderWidth = 1
    }
    
    
}

extension UIImageView {
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 6, height: 6)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 3.0
//        self.layer.cornerRadius = self.layer.frame.width/2
//        self.clipsToBounds = true
        self.layoutIfNeeded()
    }
}
