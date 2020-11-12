//
//  TableViewContorllerArtur.swift
//  SolarSystem3
//
//  Created by Artur Gedakyan on 08.11.2020.
//

import UIKit

class TableViewControllerArtur: UITableViewController {
    
    var planetList = Planet.getPlanets()
    var planetListShuffle: [String] = []
    var numOfPoints = 0
    var count = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 60
        navigationItem.leftBarButtonItem = editButtonItem
        showAlertView(title: "Задание №1",
                      message: "Расставь планеты в порядке убывания от Солнца")
        planetListShuffle = planetList.map {$0.name}.shuffled()
    }
    
    func next() {
        let storyboard = UIStoryboard(name: "hayyim", bundle: nil)
        let nextVC = storyboard.instantiateViewController(identifier: "hayyim") as! MassViewController
        self.present(nextVC, animated: true, completion: nil)
        
//        performSegue(withIdentifier: "hayyim0", sender: nil)
    }
    
    
    @IBAction func checkButtonPress(_ sender: UIBarButtonItem) {
        
        let namesFromPlanetList = planetList.map {$0.name}
        let namesFromNewPlanetList = planetListShuffle
        
        if namesFromPlanetList == namesFromNewPlanetList || count == 6  {
            switch count {
            case 0:
                numOfPoints = 5
                showAlertView(
                    title: "Отлично!",
                    message: "С первого раза! Получи - \(numOfPoints) баллов!"
                )
            case 1:
                numOfPoints = 4
                showAlertView(
                    title: "Очень хорошо!",
                    message: "Получи - \(numOfPoints) балла!"
                )
            case 2:
                numOfPoints = 3
                showAlertView(
                    title: "Хорошо!",
                    message: "Получи - \(numOfPoints) балла!"
                )
            case 3:
                numOfPoints = 2
                showAlertView(
                    title: "Неплохо!",
                    message: "Получи - \(numOfPoints) балла!"
                )
            case 4, 5:
                numOfPoints = 1
                showAlertView(
                    title: "Пришлось немного повозиться",
                    message: "но ты все-таки заработал \(numOfPoints) балл!"
                )
            default:
                numOfPoints = 0
                showAlertView(
                    title: "((",
                    message: "но ты можешь заработать баллы в следующих заданиях"
                )
            }
            next()

        } else  {
            if count > 3 {
                showAlertView(
                    title: "Подсказка",
                    message: "Сверху Меркурий, внизу Нептун, может, это тебе поможет)"
                )
            }
            count += 1
            showAlertView(title: "не-а", message: "попробуй еще")
            
        }
    }
    
    
    private func showAlertView(title: String,
                               message: String,
                               textField: UITextField? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ок", style: .default) { _ in
            textField?.text = nil
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! MassViewController
        nextVC.numOfPoints = numOfPoints
    }
    
}

extension TableViewControllerArtur {
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        planetList.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "planetName",
                                                 for: indexPath)
        let planet = planetListShuffle[indexPath.row]
        cell.textLabel?.text = planet
        cell.textLabel?.numberOfLines = 0
        //          cell.detailTextLabel?.text = planet.distanceToSun
        cell.imageView?.image = UIImage(named: planet)
        //
        return cell
    }
}

extension TableViewControllerArtur {
//    override func tableView(_ tableView: UITableView,
//                            didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let planet = planetListShuffle[indexPath.row]
//        performSegue(withIdentifier: "showDetails", sender: planet)
//    }
    
    override func tableView(
        _ tableView: UITableView,
        editingStyleForRowAt indexPath: IndexPath
    ) -> UITableViewCell.EditingStyle {
        .none
    }
    
    override func tableView(
        _ tableView: UITableView,
        shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        let currentPlanet = planetListShuffle.remove(at: sourceIndexPath.row)
        planetListShuffle.insert(currentPlanet, at: destinationIndexPath.row)
    }
    
}
