//
//  FilterController.swift
//  Cars Test App iPad
//
//  Created by Юра Гейц on 06.04.2022.
//

import Foundation
import UIKit

extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: - AlertView
    
    func openFilter()  {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250, height: 250)
        
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        pickerView.delegate = self
        pickerView.dataSource = self
        vc.view.addSubview(pickerView)
        
        let alert = UIAlertController(title: "Filter", message: nil, preferredStyle: .alert)
        alert.setValue(vc, forKey: "contentViewController")
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            let selectedRow = pickerView.selectedRow(inComponent: 0)
            self.selectedFilter = self.filterComponents[selectedRow]
            self.filter()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    //MARK: - Filter
    func filter() {
        filteredCars = []
        
        if selectedFilter == filterComponents[0] {
            isFiltering = false
        } else {
            isFiltering = true
            print(selectedFilter)
            //ChangeButtonText navigationBar.topItem?.title = selectedFilter
            let selectedState = selectedFilter.lowercased()
            
            guard let cars = cars else { return }
            
            for car in cars {
                if car.state == selectedState {
                    filteredCars.append(car)
                }
            }
        }
        filterButton.setTitle(selectedFilter, for: .normal)
        carsTableView.reloadData()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filterComponents.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filterComponents[row]
    }
}
