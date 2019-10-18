//
//  ViewController.swift
//  CoreDataTrip
//
//  Created by SRS on 14/10/19.
//  Copyright © 2019 Harish Kshirsagar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collViewUserRecords: UICollectionView!
    
    var employeeArray = [EmployeeRecord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collViewUserRecords.delegate = self
        self.collViewUserRecords.dataSource = self
        
        self.collViewUserRecords.register(UINib.init(nibName: "UserInfoCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        self.title = "CoreData Trip"

    NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.getNotify),
                                               name: NSNotification.Name(rawValue: "GetNotifiy"),
                                               object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        CoreDataManager.fetchedData { (employeeArray1) in
            
            self.employeeArray = employeeArray1
            
            DispatchQueue.main.async {
                self.collViewUserRecords.reloadData()
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return employeeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collViewUserRecords.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! UserInfoCell
        cell.lblName.text = employeeArray[indexPath.row].name
        cell.imgViewUser.addShadow()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let ARC = sb.instantiateViewController(withIdentifier: "AddRecordVC") as! AddRecordVC
        ARC.isFrom = .Edit
        ARC.indexDetail = indexPath.row
        navigationController?.pushViewController(ARC, animated: true)
    }

    
    @IBAction func btnAddRecordClicked(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let ARC = sb.instantiateViewController(withIdentifier: "AddRecordVC") as! AddRecordVC
        navigationController?.pushViewController(ARC, animated: true)
    }
    
    @IBAction func trashClicked(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController.init(title: "Warning", message: "Really want to delete all records from Database?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        let OkAction = UIAlertAction.init(title: "OK", style: .cancel) { (action) in
            
            CoreDataManager.deleteAllRecord()
            
        }
        alert.addAction(OkAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func getNotify(notification: Notification) {
        
        DispatchQueue.main.async {
            self.collViewUserRecords.reloadData()
        }
    }

}

