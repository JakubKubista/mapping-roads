//
//  DetailViewController.swift
//  iOS Projekt
//
//  Created by student on 19/04/16.
//  Copyright © 2016 xkubist1. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Foundation
import MessageUI

// Třída slouží pro zobrazení detailu konkrétní cesty a její možné manipulace a exporty.

class DetailViewController:UIViewController,MKMapViewDelegate,CLLocationManagerDelegate,MFMailComposeViewControllerDelegate {
    
    

    @IBOutlet weak var informace: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    var myLocations: [CLLocation]?
    
    var jsonSendArray:[String]? = nil
    let yourJsonFormat: String = "JSONFile"
    var mailComposerVC = MFMailComposeViewController()
    var dateFormatter = NSDateFormatter()
    var timeFormatter = NSDateFormatter()
    var detailItem:Way? = nil
    
    func configureView() {
        self.myLocations = NSKeyedUnarchiver.unarchiveObjectWithData((detailItem?.location)!) as? [CLLocation]
        
        dateFormatter.dateFormat = "dd. MM. yyyy"
        timeFormatter.dateFormat = "HH:mm:ss"
        let numOfLoc = myLocations!.count-1
        let da = dateFormatter.stringFromDate(myLocations![0].timestamp)
        let stti = timeFormatter.stringFromDate(myLocations![0].timestamp)
        let enti = timeFormatter.stringFromDate(myLocations![numOfLoc].timestamp)
        
        var i = 0
        var a:Double = 0
        var b:Double = 0
        for location in myLocations!
        {
            a += location.speed
            i += 1
        }
        b = a/Double(i+1)
        let sp =  Double(round(1000*b)/1000)
        
        if(detailItem?.doprava=="" || detailItem?.doprava==""){
        informace.text = " Název: \(detailItem!.nazev!)\n Datum: \(da)\n Čas zahájení: \(stti)\n Čas ukoncení: \(enti)\n Průměrná rychlost: \(sp) Km/h"
        }else{
        informace.text = " Název: \(detailItem!.nazev!)\n Datum: \(da)\n Čas zahájení: \(stti)\n Čas ukoncení: \(enti)\n Průměrná rychlost: \(sp) Km/h\n Terén: \(detailItem!.teren!)\n Doprava: \(detailItem!.doprava!)"
        }
        
        setupMapView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func vratitZpet(sender: AnyObject) {
         self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setupMapView(){
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        let center = CLLocationCoordinate2D(latitude: myLocations![0].coordinate.latitude, longitude: myLocations![0].coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.017, longitudeDelta: 0.017))
        
        mapView.setRegion(region, animated: true)
        
        var a:[CLLocationCoordinate2D] = []
        for location in myLocations!
        {
            a.append(location.coordinate)
        }
        let polyline = MKPolyline(coordinates: &a, count: a.count)
        mapView.addOverlay(polyline)
        
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 4
            return polylineRenderer
        }
        return nil
    }

    
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 250
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(
            location.coordinate,
            regionRadius,
            regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func exportJSON(sender: AnyObject){
        setJsonArray()
        exportJsonBasic()
        //exportJsonSession()
        //exportEmail()
    }
    func setJsonArray(){
        let numOfLoc = myLocations!.count-1
        jsonSendArray  = [
            "Dodatecne udaje:",
            String(detailItem!.nazev!),
            String(detailItem!.teren!),
            String(detailItem!.doprava!),
            "Pocatecni pozice:",
            String(myLocations![0].coordinate.latitude),
            String(myLocations![0].coordinate.longitude),
            "Konecna pozice:",
            String(myLocations![numOfLoc].coordinate.latitude),
            String(myLocations![numOfLoc].coordinate.longitude)
        ]
    }
    
    func exportJsonBasic(){
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(jsonSendArray!, options: NSJSONWritingOptions.PrettyPrinted)
            
            let theJSONText = NSString(data: jsonData,
                                       encoding: NSASCIIStringEncoding)
            print("JSON data k odeslani \(theJSONText!)")
            
        }catch let error as NSError{
            print(error.description)
        }
    }
    
    
    func exportJsonSession(){
        var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var session = NSURLSession(configuration: configuration)
        var usr = "xkubist1"
        var pwdCode = "mojePID"
        
        let url = NSURL(string:"http://localhost:8300")
        let request = NSMutableURLRequest(URL: url!)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        do{
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(jsonSendArray!, options: NSJSONWritingOptions())
        }catch let error as NSError{
            print(error.description)
        }
        
        let task = session.dataTaskWithRequest(request) {
            data, response, error in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    print("response was not 200: \(response)")
                    return
                }
            }
            if (error != nil) {
                print("error submitting request: \(error)")
                return
            }
            do{
            let result = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? NSDictionary
            print(result)
            }catch let error as NSError{
                print(error.description)
            }
        }
        task.resume()
    }
    
    /*
     Chtel jsem to udelat jinak nez ostatni, ale export pri exportu do mailu je chyba v aktualnim simulatoru, 
     vice se muzete dozvedet napr zde:
     
     stackoverflow.com/questions/25604552/i-have-real-misunderstanding-with-mfmailcomposeviewcontroller-in-swift-ios8-in
     
     Zkousel jsem MFMailComposeViewController nadefinovat v ViewControlleru a pak predavat,
     ale i tak to hazelo chybu. V telefonu by melo fungovat, ale nemel jsem moznost to odzkouset
     */
    func exportEmail(){
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["david.prochazka@mendelu.cz"])
        mailComposerVC.setSubject("Zkusebni mail iOS")
        mailComposerVC.setMessageBody("Jeste aby to jelo! :D ", isHTML: false)
        return mailComposerVC
    }
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(
            title: "Email, se nepodarilo odeslat",
            message: "Zarizeni to neodeslalo. Zkontrolujte konfiguraci.",
            delegate: self,
            cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }

    func exportCSVFile() {
    }
}