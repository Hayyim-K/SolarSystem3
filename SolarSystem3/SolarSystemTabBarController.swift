//
//  SolarSystemTabBarController.swift
//  SolarSystem3
//
//  Created by Vladislav on 08.11.2020.
//

import UIKit

class SolarSystemTabBarController: UITabBarController {

    //MARK: Public Properties
    let planets = Planet.getPlanets()
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers(with: planets)
    }
    
    //MARK: Private Methods
    private func setupViewControllers(with planets: [Planet]) {
        let planetsVC = viewControllers?.first as! PlanetsViewController
        planetsVC.planets = planets
    }
    
}
