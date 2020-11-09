//
//  NumberOfSatellitesViewController.swift
//  SolarSystem3
//
//  Created by vitasiy on 08.11.2020.
//

import UIKit

class NumberOfSatellitesViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var sliderValueLabel: UILabel!
    
    @IBOutlet var planets: [UIImageView]!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    
    var numberOfPointsFromNumOfSatellitesVC = 0
    
    private let planetsList = Planet.getPlanets()
    private var planetName = ""
    private var names: [String] = []
    
    
    var numberOfPointsFromRadiusVC: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSlider()
        setElements()
        
        resultLabel.isHidden = true
        nextButton.isHidden = true
        
    }
    
    private func setElements() {
        names = planetsList.map {$0.name}
        planetName = names.randomElement() ?? "Земля"
        questionLabel.text = "Сколько спутников у планеты \(planetName)?"
        for planet in planets {
            planet.image = UIImage(named: planetName)
        }
    }
    
    
    private func setSlider() {
        let numbersOfSatellite = planetsList.map {$0.numberOfSatellite}
        slider.minimumValue = Float(numbersOfSatellite.min() ?? 0)
        slider.maximumValue = Float(numbersOfSatellite.max() ?? 63)
        slider.value = slider.maximumValue / 2
        
    }
    
    
    
    @IBAction func sliderAction() {
        
        sliderValueLabel.text = String(format: "%1.2f", slider.value)
        let currentValue = slider.value / slider.maximumValue
        switch currentValue {
        case 0..<0.2:
            planets[0].isHidden = false
            planets[1].isHidden = true
            planets[2].isHidden = true
            planets[3].isHidden = true
            planets[4].isHidden = true
            planets[5].isHidden = true
            planets[6].isHidden = true
            planets[7].isHidden = true
        case 0.2..<0.4:
            planets[0].isHidden = false
            planets[1].isHidden = false
            planets[2].isHidden = true
            planets[3].isHidden = true
            planets[4].isHidden = true
            planets[5].isHidden = true
            planets[6].isHidden = true
            planets[7].isHidden = true
        case 0.4..<0.6:
            planets[0].isHidden = false
            planets[1].isHidden = false
            planets[2].isHidden = false
            planets[3].isHidden = false
            planets[4].isHidden = true
            planets[5].isHidden = true
            planets[6].isHidden = true
            planets[7].isHidden = true
        case 0.6..<0.8:
            planets[0].isHidden = false
            planets[1].isHidden = false
            planets[2].isHidden = false
            planets[3].isHidden = false
            planets[4].isHidden = false
            planets[5].isHidden = false
            planets[6].isHidden = true
            planets[7].isHidden = true
        default:
            planets[0].isHidden = false
            planets[1].isHidden = false
            planets[2].isHidden = false
            planets[3].isHidden = false
            planets[4].isHidden = false
            planets[5].isHidden = false
            planets[6].isHidden = false
            planets[7].isHidden = false
        }
        
    }
    
    
    
    @IBAction func checkingButtonPassed() {
        let index = names.firstIndex(of: planetName)
        
        let rightResult = planetsList[index ?? 3].numberOfSatellite
        
        let result = 1 - (abs(Float(rightResult) - slider.value) / slider.maximumValue)
        
        switch result {
        case 0.1..<0.2: numberOfPointsFromNumOfSatellitesVC  = 1
        case 0.2..<0.4: numberOfPointsFromNumOfSatellitesVC  = 2
        case 0.4..<0.6: numberOfPointsFromNumOfSatellitesVC  = 3
        case 0.6..<0.8: numberOfPointsFromNumOfSatellitesVC  = 4
        case 0.8...1: numberOfPointsFromNumOfSatellitesVC  = 5
        default: numberOfPointsFromNumOfSatellitesVC  = 0
        }
        
        resultLabel.text = "Вы оказались близки к истине, ваш результат \(numberOfPointsFromNumOfSatellitesVC)баллов!"
        
        contentView.isHidden = true
        resultLabel.isHidden = false
        nextButton.isHidden = false
    }
    
    @IBAction func nextButtonPressed() {
        numberOfPointsFromNumOfSatellitesVC += numberOfPointsFromRadiusVC
        performSegue(withIdentifier: "satelliteVC", sender: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultVC = segue.destination as! ResultsViewController
        resultVC.numberOfPointsFromNumOfSatellitesVC  = numberOfPointsFromNumOfSatellitesVC
    }
    
    
}

