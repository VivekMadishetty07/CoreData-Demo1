//
//  ViewController.swift
//  CoreData Demo1
//
//  Created by Vivek Madishetty on 2020-01-16.
//  Copyright © 2020 Vivek Madishetty. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // First we create an instance of the app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        /*
         Second we need the context.
         this context is the manager like location manager, audio manager etc
         */
        let context = appDelegate.persistentContainer.viewContext
        
        //3rd step - write into context
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        newUser.setValue("Vicky", forKey: "name")
        newUser.setValue(4379256843, forKey: "phone")
        newUser.setValue("madishetty.vivek@gmail.ca", forKey: "email")
        newUser.setValue(24, forKey: "age")
        
        // 4th step - save context
        
        do{
           try context.save()
            print(newUser, "is saved" )
        }catch{
            print(error)
        }
        
        
        // fetch data and load it
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            // finding madishetty.vivek@gmail.ca
        request.predicate = NSPredicate(format: "email contains %@", ".ca")
        
        request.predicate = NSPredicate(format: "name=%@", "Vivek")
        request.returnsObjectsAsFaults =  false
        // we find our data
        do{
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                   if let name = result.value(forKey: "name") {
                  print(name)
               }
                    if let email = result.value(forKey: "email"){
                        print(email)
                        //update email address to "madishetty.vivek@gmail.ca"
                        let str = email as! String
                       let newEmail = str.replacingOccurrences(of: ".ca", with: ".com")
                        result.setValue(newEmail, forKey: "email")
                        do{
                            try context.save()
                            print(result, "is saved")
                        } catch {
                            print(error)
                        }
                        
                    }
 
           if(1==1)
           {
            context.delete(result)
            do{
                try context.save()
            } catch {
                print(error)
            }
                   
                    }
            }
            
            }
        } catch {
            print(error)
        }
        
        

        
    }


}

