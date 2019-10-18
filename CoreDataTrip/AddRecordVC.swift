//
//  AddRecordVC.swift
//  CoreDataTrip
//
//  Created by SRS on 14/10/19.
//  Copyright © 2019 Harish Kshirsagar. All rights reserved.
//

import UIKit
import CoreData

class AddRecordVC: UIViewController {

    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfCompanyName: UITextField!
    @IBOutlet weak var tfAge: UITextField!
    @IBOutlet weak var tfBirthDate: UITextField!
    @IBOutlet weak var tfExpectedCTC: UITextField!
    @IBOutlet weak var tfCurrentCTC: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    
    enum ISFROM {
        case Edit
        case Add
        case None
    }
    
    var indexDetail = Int()
    var isFrom : ISFROM = .None
    var employeeArray = [EmployeeRecord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSave.layer.cornerRadius = 20
        btnSave.clipsToBounds = true
        
        btnDelete.layer.cornerRadius = 20
        btnDelete.clipsToBounds = true
        
        
        if isFrom == .Edit{
            self.showData()
            self.btnSave.setTitle("Update", for: .normal)
        }
    }
    
    @IBAction func btnSaveClicked(_ sender: UIButton) {
        
        
        if isFrom == .Edit{
            CoreDataManager.UpdatEmployeeByName(name: tfUserName.text!, companyName: tfCompanyName.text!, age: tfAge.text!, currentCTC: tfCurrentCTC.text!, expectedCTC: tfExpectedCTC.text!, birthDate: tfBirthDate.text!)
            self.navigationController?.popViewController(animated: true)
        }else{
            
            let employee = EmployeeRecord(context: CoreDataManager.context)
            
            if let temp = tfUserName.text{
                print("uname is \(temp)")
                employee.name = temp
            }
            
            
            if let temp = tfCompanyName.text{
                print("tfCompanyName is \(temp)")
                employee.companyName = temp
            }
            
            
            if let temp = tfAge.text{
                print("tfAge is \(temp)")
                employee.age = temp
            }
            
            
            if let temp = tfBirthDate.text{
                print("tfBirthDate is \(temp)")
                employee.birthDate = temp
            }
            
            
            if let temp = tfCurrentCTC.text{
                print("tfCurrentCTC is \(temp)")
                employee.currentCTC = temp
            }
            
            if let temp = tfExpectedCTC.text{
                print("tfExpectedCTC is \(temp)")
                employee.expectedCTC = temp
            }
            
            CoreDataManager.saveContext()
            NotificationCenter.default.post(name: Notification.Name("GetNotifiy"), object: nil)
            self.navigationController?.popViewController(animated: true)

        }
    }
    
    @IBAction func deleteClicked(_ sender: UIButton) {
        
        CoreDataManager.deleteRecord(name : tfUserName.text!)
        NotificationCenter.default.post(name: Notification.Name("GetNotifiy"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func showData(){
        
        CoreDataManager.fetchedData { (employeeArray1) in
            
            self.employeeArray = employeeArray1
            
            
            if let temp = self.employeeArray[self.indexDetail].name{
                    self.tfUserName.text = temp
                }
                
            if let temp = self.employeeArray[self.indexDetail].companyName{
                    self.tfCompanyName.text = temp
                }
                
            if let temp = self.employeeArray[self.indexDetail].age{
                    self.tfAge.text = temp
                }
                
            if let temp = self.employeeArray[self.indexDetail].birthDate{
                    self.tfBirthDate.text = temp
                }
                
            if let temp = self.employeeArray[self.indexDetail].currentCTC{
                    self.tfCurrentCTC.text = temp
                }
                
            if let temp = self.employeeArray[self.indexDetail].expectedCTC{
                    self.tfExpectedCTC.text = temp
                }
            
        
        }
    }

}
