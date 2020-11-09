//
//  RadiusViewController.swift
//  SolarSystem3
//
//  Created by vitasiy on 08.11.2020.
//

import UIKit

class RadiusViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var sliderValueLabel: UILabel!
    @IBOutlet weak var planetImageView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var tryButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var numberOfPointsFromRadiusVC = 0
    
    private let planetsList = Planet.getPlanets()
    private var planetName = ""
    private var names: [String] = []
    
    
    var numberOfPointsFromMassVC: Int!
    
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
        questionLabel.text = "Каков радиус планеты \(planetName)?"
        planetImageView.image = UIImage(named: planetName)
    }
    
    
    private func setSlider() {
        let mass = planetsList.map {$0.radius}
        slider.minimumValue = mass.min() ?? 0
        slider.maximumValue = mass.max() ?? 318
        slider.value = slider.maximumValue / 2
        
    }
    
    
    
    @IBAction func sliderAction() {
        
        sliderValueLabel.text = String(format: "%1.2f", slider.value)
        let currentValue = Double(slider.value / slider.maximumValue) * 128.0
        planetImageView.frame.size = CGSize(
            width: currentValue > 10 ? currentValue : 10,
            height: currentValue > 10 ? currentValue : 10
        )
    }
    
    
    
    @IBAction func checkingButtonPassed() {
        let index = names.firstIndex(of: planetName)
        
        let rightResult = planetsList[index ?? 3].radius
        
        let result = 1.0 - (abs(rightResult - slider.value) / slider.maximumValue)
        
        switch result {
        case 0.1..<0.2: numberOfPointsFromRadiusVC = 1
        case 0.2..<0.4: numberOfPointsFromRadiusVC = 2
        case 0.4..<0.6: numberOfPointsFromRadiusVC = 3
        case 0.6..<0.8: numberOfPointsFromRadiusVC = 4
        case 0.8...1: numberOfPointsFromRadiusVC = 5
        default: numberOfPointsFromRadiusVC = 0
        }
        
        resultLabel.text = "Вы оказались близки к истине, ваш результат \(numberOfPointsFromRadiusVC)баллов!"
        
        questionLabel.isHidden = true
        sliderValueLabel.isHidden = true
        slider.isHidden = true
        planetImageView.isHidden = true
        tryButton.isHidden = true
        resultLabel.isHidden = false
        nextButton.isHidden = false
    }
    
    @IBAction func nextButtonPressed() {
        numberOfPointsFromRadiusVC += numberOfPointsFromMassVC
        performSegue(withIdentifier: "satelliteVC", sender: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultVC = segue.destination as! NumberOfSatellitesViewController
        resultVC.numberOfPointsFromRadiusVC = numberOfPointsFromRadiusVC
    }
    
    
}
