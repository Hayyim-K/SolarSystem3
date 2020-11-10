//
//  MassViewController.swift
//  SolarSystem3
//
//  Created by vitasiy on 08.11.2020.
//

import UIKit

class MassViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var sliderValueLabel: UILabel!
    @IBOutlet weak var bigPlanetImageView: UIImageView!
    @IBOutlet weak var smallPlanetImageView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var tryButton: UIButton!
    
    var numOfPoints: Int!
    var numberOfPointsFromMassVC = 0
    
    private let planetsList = Planet.getPlanets()
    private var planetName = ""
    private var names: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSlider()
        setElements()
        
        resultLabel.isHidden = true
        nextButton.isHidden = true
        sliderValueLabel.text = String(format: "%1.2f", slider.value)
    }
    
    private func setElements() {
        names = planetsList.map {$0.name}
        planetName = names.randomElement() ?? "Земля"
        questionLabel.text = "Какова масса планеты \(planetName)?"
        smallPlanetImageView.image = UIImage(named: planetName)
        bigPlanetImageView.image = UIImage(named: planetName)
    
    }
    
    
    private func setSlider() {
        let mass = planetsList.map {$0.mass}
        slider.minimumValue = mass.min() ?? 0
        slider.maximumValue = mass.max() ?? 11.2
        slider.value = slider.maximumValue / 2
    }
    
    
    
    @IBAction func sliderAction() {
        
        sliderValueLabel.text = String(format: "%1.2f", slider.value)
    }
    
    
    
    
    
    
    @IBAction func checkingButtonPassed() {
        let index = names.firstIndex(of: planetName)
        let rightResult = planetsList[index ?? 3].mass
        
        let result = 1.0 - (abs(rightResult - slider.value) / slider.maximumValue)
        
        switch result {
        case 0.1..<0.2: numberOfPointsFromMassVC = 1
        case 0.2..<0.4: numberOfPointsFromMassVC = 2
        case 0.4..<0.6: numberOfPointsFromMassVC = 3
        case 0.6..<0.8: numberOfPointsFromMassVC = 4
        case 0.8...1: numberOfPointsFromMassVC = 5
        default: numberOfPointsFromMassVC = 0
        }
        
        resultLabel.text = "Вы оказались близки к истине, ваш результат \(numberOfPointsFromMassVC) баллов!"
        
        questionLabel.isHidden = true
        sliderValueLabel.isHidden = true
        slider.isHidden = true
        bigPlanetImageView.isHidden = true
        smallPlanetImageView.isHidden = true
        tryButton.isHidden = true
        resultLabel.isHidden = false
        nextButton.isHidden = false
        
    }
    
    @IBAction func nextButtonPressed() {
        numberOfPointsFromMassVC += numOfPoints
        performSegue(withIdentifier: "radiusVC", sender: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultVC = segue.destination as! RadiusViewController
        resultVC.numberOfPointsFromMassVC = numberOfPointsFromMassVC
    }
    
    
    
}
