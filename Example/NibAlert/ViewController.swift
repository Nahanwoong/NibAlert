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
            .addOption(title: "OK", style: .default, action: { action, alert in
                self.textLabel.text = "Alert OK Button Clicked!"
            })
            .show(at: self)
    }
    
    @IBAction func onTappedAlertSheetButton(_ sender: UIButton) {
        Alert("Test Title", "Test Message", style: .actionSheet)
            .addOption(title: "Cancel", style: .cancel)
            .addOption(title: "OK", style: .default, action: { action, alert in
                self.textLabel.text = "Alert Sheet OK Button Clicked!"
            })
            .show(at: self)
    }
    
    @IBAction func onTappedTextFieldAlertButton(_ sender: UIButton) {
        Alert("Sign In")
            .addTextField({ (textField) in
                textField.placeholder = "Email"
                textField.textContentType = .emailAddress
            })
            .addTextField({
                $0.placeholder = "password"
                $0.isSecureTextEntry = true
            })
            .addOption(title: "Cancel", style: .cancel)
            .addOption(title: "OK", style: .default, action: { action, alert in
                guard let textFields = alert.textFields, textFields.count == 2 else { return }
                print("Email: \(textFields[0].text ?? "")")
                print("Password: \(textFields[1].text ?? "")")
            })
            .show(at: self)
    }
    
    @IBAction func onTappedContentViewAlertButton(_ sender: UIButton) {
        let contentView = TableViewController()
        Alert()
            .setContentView(contentView)
            .addOption(title: "OK")
            .show(at: self)
    }
}

