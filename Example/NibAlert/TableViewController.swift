//
//  TableViewController.swift
//  NibAlert_Example
//
//  Created by MacBook-Na on 2020/10/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import NibAlert

class TableViewController: UITableViewController, AlertContentViewable {
    
    var alertContentSize: CGSize = CGSize(width: 300, height: 150)
    
    lazy var models: [CellModel] = {
        var model: [CellModel] = []
        model.append(CellModel(name: "Apple"))
        model.append(CellModel(name: "Google"))
        model.append(CellModel(name: "Twitter"))
        model.append(CellModel(name: "Naver"))
        model.append(CellModel(name: "KaKao"))
        model.append(CellModel(name: "Facebook"))
        return model
    }()
    
    override func viewDidLoad() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].name
        cell.accessoryType = models[indexPath.row].isSelected ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedRow(row: indexPath.row)
        tableView.reloadData()
    }
    
    private func selectedRow(row: Int) {
        for i in 0..<models.count {
            models[i].isSelected = i == row
        }
    }
}
