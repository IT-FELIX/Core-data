//
//  CoreDataManager.swift
//  CoreDataTrip
//
//  Created by SRS on 14/10/19.
//  Copyright © 2019 Harish Kshirsagar. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager{
    
    private init(){}
    
    static let shared = CoreDataManager()
    
    static var context : NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    
    static var persistentContainer: NSPersistentContainer = {
    
        let container = NSPersistentContainer(name: "CoreDataTrip")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
            
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    
   static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
          
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    
   static func fetchedData(completion: (([EmployeeRecord]) -> ())?){
        
        var nameArray = [EmployeeRecord]()
        let managedContext = persistentContainer.viewContext
        
        do{
            nameArray = try managedContext.fetch(EmployeeRecord.fetchRequest())
            completion!(nameArray)
            
        }catch{
            print(error)
        }
    }
    
    
   static func UpdatEmployeeByName(name:String, companyName:String, age:String, currentCTC:String, expectedCTC:String, birthDate:String) {
    
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "EmployeeRecord")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format:"name = '\(name)'")
        
        let result = try? context.fetch(fetchRequest)
    
        
        if result?.count == 1 {
            
            let dic = result![0]
            dic.setValue(name, forKey: "name")
            dic.setValue(companyName, forKey: "companyName")
            dic.setValue(age, forKey: "age")
            dic.setValue(currentCTC, forKey: "currentCTC")
            dic.setValue(expectedCTC, forKey: "expectedCTC")
            
            do{
                try context.save()
            }
            catch
            {
                print(error)
            }
        }
    }
    
    
    static func deleteRecord(name : String){
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "EmployeeRecord")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format:"name = '\(name)'")
        
        let result = try? context.fetch(fetchRequest)
        
        for item in result! {
            context.delete(item)
        }
        
        do {
            try context.save()
        } catch {
        }
    }

    
   static func deleteAllRecord() {
    
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "EmployeeRecord")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            NotificationCenter.default.post(name: Notification.Name("GetNotifiy"), object: nil)

        } catch {
            print ("There was an error")
        }
    }
    
}
