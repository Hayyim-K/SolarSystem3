//
//  PlanetsViewController.swift
//  SolarSystem3
//
//  Created by Vladislav on 08.11.2020.
//

import UIKit

class PlanetsViewController: UIViewController {
    
    //MARK: Public Properties
    var planets = Planet.getPlanets()
    var chosePlanet: Int = 0
    
    @IBOutlet var planetNameLables: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabeles()
        
    }
    
    private func setLabeles() {
        let names = planets.map {$0.name}
        for (label, name) in zip(planetNameLables, names) {
            label.text = name
        }
        
    }
    
    //MARK: Override Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let planetsVC = segue.destination as! AboutPlanetViewController
        planetsVC.planets = planets
        planetsVC.pushButtonPlanet = chosePlanet
    }
    
    //MARK: IB Actions
    @IBAction func planetPushButton(_ sender: UIButton) {
        chosePlanet = sender.tag
        performSegue(withIdentifier: "AboutPlanet", sender: self)
    }
    
    
}
