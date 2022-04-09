//
//  CarsListTableViewExtension.swift
//  Cars Test App iPad
//
//  Created by Юра Гейц on 06.04.2022.
//

import Foundation
import UIKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let carsCount = cars?.count else { return 0 }
        return isFiltering == true ? filteredCars.count : carsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carCell", for: indexPath) as! CarTableViewCell
        
        guard let cars = cars else { return cell }
        let car = isFiltering == true ? filteredCars[indexPath.row] : cars[indexPath.row]
        cell.configure(with: car)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //show info about car
        print("IndexPath row \(indexPath.row)")
        guard let selectedCar = cars?[indexPath.row] else { return }
        let car = isFiltering == true ? filteredCars[indexPath.row] : selectedCar
        showInfo(car)
    }
    
    private func showInfo(_ selectedCar: Car) {
        print("Showing info")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let infoView = storyboard.instantiateViewController(withIdentifier: "infoStoryboard") as! InfoViewController
        infoView.car = selectedCar
        infoView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        infoView.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(infoView, animated: true, completion: nil)
    }
}
