//
//  ViewController.swift
//  iOS Projekt
//
//  Created by student on 11/04/16.
//  Copyright © 2016 xkubist1. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

// Třída zodpovídá za průběh mapování cesty od doby kdy zmážneme start až po dobu ukončení.

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var information: UILabel!
    @IBOutlet weak var pressButton: UIButton!
    @IBOutlet weak var zrusButton: UIBarButtonItem!
    @IBOutlet weak var zadejUdajeButton: UIButton!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var locationManager :CLLocationManager!
    var myLocations: [CLLocation] = []
    var centerOnLocation:Bool = true
    var dateFormatter = NSDateFormatter()
    
	
	// Úvodní obrazovka a defaultní hodnoty.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.information.text = "Vítejte v aplikaci mapování cest"
            zadejUdajeButton.setTitle("", forState: UIControlState.Normal)
        zrusButton.enabled = false
        
        /*Pro pripad mendelu:
        let initialLocation = CLLocation(latitude: 49.209584, longitude: 16.614262)
        centerMapOnLocation(initialLocation)*/
        
        setupLocationManager()
        locationManager.stopUpdatingLocation()
        setupMapView()
        
    }
    
	// Funkce umožňuje předat data. Pracuje se s nimi podle identifikátoru.
	// V případě že je id. roven showWaysT, je umožněno mapování zpřístupněním tlačítka Start.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showWaysF" {
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! CestyViewController
            controller.prvni = false
            controller.myLocations = myLocations
        }else if segue.identifier == "showWaysT" {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! CestyViewController
            controller.prvni = true
            controller.myLocations = myLocations
            
            self.dismissViewControllerAnimated(true, completion: nil)
            self.viewDidLoad()
            myLocations = []
            mapView.removeOverlays(mapView.overlays)
            pressButton.setTitle("Start", forState: UIControlState.Normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	// Metoda zavolána po spuštění nastaví managera lokace pro detekování aktuální pozice.
	// Dále zajišťuje vycentrování, vzdálenost pohledu, možnost zastavení mapování.
    @IBAction func startAction(sender: UIButton) {

        if (pressButton.titleLabel?.text=="Start")||(pressButton.titleLabel?.text=="Pokračovat"){
            pressButton.setTitle("Stop", forState: UIControlState.Normal)
            setupLocationManager()
            
        }else if (pressButton.titleLabel?.text=="Stop"){
            zrusButton.enabled = true
            pressButton.setTitle("", forState: UIControlState.Normal)
            self.information.text = "";
            zadejUdajeButton.setTitle("Zadat doplňující údaje", forState: UIControlState.Normal)
            
            let region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 2000, 2000)
            mapView.setRegion(region, animated: true)
            
            locationManager.stopUpdatingLocation()
            locationManager.distanceFilter = 100
        }

    }
    
    @IBAction func zobrazitCesty(sender: AnyObject) {
    }
	
    // Služba pro iniciaci lokace.
    func setupLocationManager(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
	// Funkce pro nastavení defaultního startovního bodu simulace.
    func setupMapView(){
        mapView.delegate = self
//        mapView.mapType = MKMapType.Satellite
        mapView.showsUserLocation = true
        
        let center = CLLocationCoordinate2D(latitude: 34.052235, longitude: -118.243683)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))
        
        mapView.setRegion(region, animated: true)
    }
    
    // Funkce pro nastavení trasy, vykreslení křivky trasy, zachycení rychlosti a data.
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        let la = Double(round(1000*locations[0].coordinate.latitude)/1000)
        let lo = Double(round(1000*locations[0].coordinate.longitude)/1000)
        dateFormatter.dateFormat = "dd. MM. yyyy HH:mm:ss"
        let ti = dateFormatter.stringFromDate(locations[0].timestamp)
        let sp = locations[0].speed
        
        information.text = " Souřadnice: \(la), \(lo)\n Datum: \(ti)\n Rychlost: \(sp) Km/h"
        myLocations.append(locations[0] as CLLocation)
        
        let spanX = 0.007
        let spanY = 0.007
        let newRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        mapView.setRegion(newRegion, animated: true)
        
        if (myLocations.count > 1){
            let sourceIndex = myLocations.count - 1
            let destinationIndex = myLocations.count - 2
            
            let c1 = myLocations[sourceIndex].coordinate
            let c2 = myLocations[destinationIndex].coordinate
            var a = [c1, c2]
            let polyline = MKPolyline(coordinates: &a, count: a.count)
            mapView.addOverlay(polyline)
        }
    }
    
    // Funkce pro úpravu křivky trasy.
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 4
            return polylineRenderer
        }
        return nil
    }

	// Funkce pro zaměření sledovaného bodu na určitou vzdálenost.
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 250 // metru
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(
            location.coordinate,
            regionRadius,
            regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    
    @IBAction func resetCesty(sender: AnyObject) {
         self.dismissViewControllerAnimated(true, completion: nil)
         self.viewDidLoad()
         myLocations = []
         mapView.removeOverlays(mapView.overlays)
         pressButton.setTitle("Start", forState: UIControlState.Normal)
    }
}

