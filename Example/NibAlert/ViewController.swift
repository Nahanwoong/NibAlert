//
//  ViewController.swift
//  NibAlert
//
//  Created by nibdevn@gmail.com on 10/11/2020.
//  Copyright (c) 2020 nibdevn@gmail.com. All rights reserved.
//

import UIKit
import NibAlert

class ViewController: UIViewController {
    
    @IBOutlet weak var alertButton: UIButton!
    @IBOutlet weak var alertSheetButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTappedAlertButton(_ sender: UIButton) {
        Alert("Test Title", "Test Message", style: .alert)
            .addOption(title: "Cancel", style: .cancel)
            .addOption(title: "OK", style: .default, action: { action in
                self.textLabel.text = "Alert OK Button Clicked!"
            })
            .show(at: self)
    }
    
    @IBAction func onTappedAlertSheetButton(_ sender: UIButton) {
        Alert("Test Title", "Test Message", style: .actionSheet)
            .addOption(title: "Cancel", style: .cancel)
            .addOption(title: "OK", style: .default, action: { action in
                self.textLabel.text = "Alert Sheet OK Button Clicked!"
            })
            .show(at: self)
    }
}

