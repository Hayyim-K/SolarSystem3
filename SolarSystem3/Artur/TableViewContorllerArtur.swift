//
//  TableViewContorllerArtur.swift
//  SolarSystem3
//
//  Created by Artur Gedakyan on 08.11.2020.
//

import UIKit

class TableViewControllerArtur: UITableViewController {
    
    var planetList = Planet.getPlanets()
    var planetListShuffle = Planet.getPlanets()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
        navigationItem.leftBarButtonItem = editButtonItem
        planetListShuffle.shuffle()
        showAlertView(title: "оК", message: "Расставь планеты в порядке убывания от Солнца")
    }
    
    @IBAction func checkButtonPress(_ sender: UIBarButtonItem) {
    
        let namesFromPlanetList = planetList.map {$0.name}
        let namesFromNewPlanetList = planetListShuffle.map {$0.name}
        
        var count = 0
        var numOfPoints = 0
        
        if namesFromPlanetList == namesFromNewPlanetList  {
            switch count {
            case 0: numOfPoints = 5
            case 1...2: numOfPoints = 4
            case 3...5: numOfPoints = 3
            case 6...8: numOfPoints = 2
            case 9...10: numOfPoints = 1
            default: numOfPoints = 0
                showAlertView(title: "Ok", message: "Количество балов \(numOfPoints)")
                
            }
        } else  {
            count += 1
            showAlertView(title: "Ok", message: "Количество балов \(numOfPoints)")
            
        }
    }
    
//        if namesFromPlanetList == namesFromNewPlanetList {
//            showAlertView(title: "Дальше", message: "Вы молодец! Планеты в правильном порядке")
//
//        } else {
//            alert += 1
//            showAlertView(title: "Ок", message: "Попытка номер\(alert).")
//        }.


    private func showAlertView(title: String, message: String, textField: UITextField? = nil) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Закрыть", style: .default) { _ in
                textField?.text = nil
            }
            alert.addAction(okAction)
            present(alert, animated: true)
        }
    
}

extension TableViewControllerArtur {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        planetList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "planetName", for: indexPath)
        
        let planet = planetListShuffle[indexPath.row]
        cell.textLabel?.text = planet.name
        cell.textLabel?.numberOfLines = 0
        //          cell.detailTextLabel?.text = planet.distanceToSun
        cell.imageView?.image = UIImage(named: planet.name)
        //
        return cell
    }
}

extension TableViewControllerArtur {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let planet = planetListShuffle[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: planet)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .none
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let currentPlanet = planetListShuffle.remove(at: sourceIndexPath.row)
        planetListShuffle.insert(currentPlanet, at: destinationIndexPath.row)
    }
    
}
