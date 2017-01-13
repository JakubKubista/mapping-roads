//
//  UdajeViewController.swift
//  iOS Projekt
//
//  Created by student on 18/04/16.
//  Copyright © 2016 xkubist1. All rights reserved.
//

import UIKit

protocol SaveWayDelegate{
    func saveNewWay(nazev:String, teren:String, doprava:String)
}

// Kontrolér určený pro uložení nové cesty obsahující formulář s doplňujícími informacemi.

class UdajeViewController: UIViewController {
    
    var saveWayDelegate: SaveWayDelegate? = nil
    
    
    @IBOutlet weak var nazevTextField: UITextField!
    @IBOutlet weak var terenTextField: UITextField!
    @IBOutlet weak var dopravaTextField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nazevTextField.becomeFirstResponder()
        warningLabel.text=""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func vratitZpet(sender: AnyObject) {
         self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func ulozitUdaje(sender: AnyObject) {
        if(nazevTextField.text==""){
            warningLabel.text="Název cesty je povinný údaj."
        }else{
            saveWayDelegate?.saveNewWay(nazevTextField.text!, teren: terenTextField.text!, doprava: dopravaTextField.text!)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
