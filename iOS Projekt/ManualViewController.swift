//
//  ManualViewController.swift
//  iOS Projekt
//
//  Created by Kyblik on 4/23/16.
//  Copyright © 2016 xkubist1. All rights reserved.
//

import UIKit

class ManualViewController: UIViewController {

    @IBOutlet weak var textManualu: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textManualu.text=" Přednastavení při použití simulátoru:\n 1. Velikost okna iPhone 6s Plus\n Simulator->Window->Scale->50%\n 2. Nastavení simulace pro mapování\n Simulator->Debug->Location->Freeway Drive\n\n Kuchařka aplikace\n 1. Start\n 2. Mapování\n 3. Stop (nyní je možné začít od začátku)\n 4. Zadání doplňujících údajů\n 5. Uložení(nutné zadat název)\n 6. Kontrola údajů v Core Data (seznam cest)\n 7. Export (3 způsoby)"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func vratitSe(sender: AnyObject) {
         self.dismissViewControllerAnimated(true, completion: nil)
    }
}