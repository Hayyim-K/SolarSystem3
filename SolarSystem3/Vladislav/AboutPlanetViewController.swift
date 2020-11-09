//
//  AboutPlanetViewController.swift
//  SolarSystem3
//
//  Created by Vladislav on 08.11.2020.
//

import UIKit

class AboutPlanetViewController: UIViewController {
    
    //MARK: IB Outlets
    @IBOutlet weak var planetImageView: UIImageView!
    
    @IBOutlet weak var planetNameLabel: UILabel!
    @IBOutlet weak var planetMassLabel: UILabel!
    @IBOutlet weak var planetRadiusLabel: UILabel!
    @IBOutlet weak var distanceToSunLabel: UILabel!
    @IBOutlet weak var numberOfSatellitesLabel: UILabel!
    
    //MARK: Public Properties
    var planets: [Planet]!
    var pushButtonPlanet: Int!
    var chosePlanet: String = ""
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        howPlanetChoose()
        planetInfo()
    }
    
    //MARK: IB Actions
    @IBAction func closeButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    //MARK: Private Methods
    private func howPlanetChoose() {
        chosePlanet = planets[pushButtonPlanet].name
    }
    
    private func planetInfo() {
        for planet in planets {
            if planet.name == chosePlanet {
                planetImageView.image = UIImage(named: planet.name)
                planetNameLabel.text = "\(planet.name)"
                planetMassLabel.text = "Масса: \(planet.mass)"
                planetRadiusLabel.text = "Радиус: \(planet.radius)"
                distanceToSunLabel.text = "Дистанция до солнца: \(planet.distanceToSun)"
                numberOfSatellitesLabel.text = "Количество спутников: \(planet.numberOfSatellite)"
            }
        }
    }
}
