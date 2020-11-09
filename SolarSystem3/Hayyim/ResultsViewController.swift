//
//  ResultsViewController.swift
//  SolarSystem3
//
//  Created by vitasiy on 09.11.2020.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var userNameDelegate: ResultsViewControllerDelegate!
    var numberOfPointsFromNumOfSatellitesVC: Int!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userName = userNameDelegate.userNameDelegate
        resultLabel.text = "Поздравляем \(userName)!\n Ваш результат \(numberOfPointsFromNumOfSatellitesVC ?? 100)"
        
    }
}
