//
//  EmployeeRecord+CoreDataProperties.swift
//  
//
//  Created by SRS on 15/10/19.
//
//

import Foundation
import CoreData


extension EmployeeRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmployeeRecord> {
        return NSFetchRequest<EmployeeRecord>(entityName: "EmployeeRecord")
    }

    @NSManaged public var age: String?
    @NSManaged public var birthDate: String?
    @NSManaged public var companyName: String?
    @NSManaged public var currentCTC: String?
    @NSManaged public var expectedCTC: String?
    @NSManaged public var name: String?
    @NSManaged public var userImg: NSData?

}
