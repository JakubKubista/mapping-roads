//
//  CestyViewController.swift
//  iOS Projekt
//
//  Created by student on 18/04/16.
//  Copyright © 2016 xkubist1. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

// Třída vytvoří controlér, který následně spravuje tabulku view cest.

class CestyViewController: UITableViewController, NSFetchedResultsControllerDelegate,CLLocationManagerDelegate,SaveWayDelegate{
    
    var managedObjectContext: NSManagedObjectContext? = nil
    var detailViewController: DetailViewController? = nil
    var myLocations: [CLLocation]?
    var prvni:Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        saveLocationNil()
        if(prvni == true){
            self.performSegueWithIdentifier("newWay", sender: self)
        }
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }

	// Funkce umožňuje předat data. Pracuje se s nimi podle identifikátoru.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Way
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
            }
        } else if segue.identifier == "newWay" {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! UdajeViewController
            controller.saveWayDelegate = self
        }
    }
    
    func saveLocationNil(){
        let importPage =  self.storyboard!.instantiateViewControllerWithIdentifier("doplnUd") as! UINavigationController
        let controller = importPage.topViewController as! UdajeViewController
        controller.saveWayDelegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func vratitSe(sender: AnyObject) {
         self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cesticky", forIndexPath: indexPath)
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        self.configureCell(cell, withObject: object)
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let context = self.fetchedResultsController.managedObjectContext
            context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject)
            
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                //print("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
        }
    }
    
    func configureCell(cell: UITableViewCell, withObject object: NSManagedObject) {
        cell.textLabel!.text = object.valueForKey("nazev")!.description
    }
    
    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.managedObjectContext = appDel.managedObjectContext
        
        let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let entity = NSEntityDescription.entityForName("Way", inManagedObjectContext: self.managedObjectContext!)
        fetchRequest.entity = entity
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "nazev", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //print("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
        
        return _fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController? = nil
    
    // Funkce (kontrolér) pro změnu obsahu v db
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }

    // Funkce (kontrolér) volá dle zadaných parametrů funkce sloužící pro administraci cest
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Insert:
            self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Delete:
            self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        default:
            return
        }
    }
	
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            self.configureCell(tableView.cellForRowAtIndexPath(indexPath!)!, withObject: anObject as! NSManagedObject)
        case .Move:
            tableView.moveRowAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    // Funkce uloží novou cestu (entitu) do databáze.
    func saveNewWay(nazev: String, teren: String, doprava: String) {
        let context = self.fetchedResultsController.managedObjectContext
        let entity = self.fetchedResultsController.fetchRequest.entity!
        let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context)
        newManagedObject.setValue(nazev, forKey: "nazev")
        newManagedObject.setValue(teren, forKey: "teren")
        newManagedObject.setValue(doprava, forKey: "doprava")
        let archivedLocation = NSKeyedArchiver.archivedDataWithRootObject(self.myLocations!)
        newManagedObject.setValue(archivedLocation, forKey: "location")
        // Save the context.
        do {
            try context.save()
        } catch {
            print("Entita cesty nebyla ulozena \(error)")
            abort()
        }
        
    }

    
}
