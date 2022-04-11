//
//  FilterController.swift
//  Cars Test App iPad
//
//  Created by Юра Гейц on 06.04.2022.
//

import Foundation
import UIKit
import DropDown

extension MainViewController {
    
    //MARK: - Filter
    
    func openFilter()  {
        dropDown.anchorView = filterButton
        dropDown.direction = .any
        dropDown.dataSource = filterComponents
        
        dropDown.cellNib = UINib(nibName: "FilterCell", bundle: nil)
        
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? FilterCell else { return }
            
            switch item {
            case "No filter":
                cell.colorImage.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            case "Available":
                cell.colorImage.tintColor = UIColor(red: 0.733, green: 0.984, blue: 0.789, alpha: 1)
            case "Hidden":
                cell.colorImage.tintColor = UIColor(red: 0.082, green: 0.396, blue: 0.753, alpha: 1)
            case "Disabled":
                cell.colorImage.tintColor = UIColor(red: 0.984, green: 0.914, blue: 0.733, alpha: 1)
            default:
                break
            }
        }
        
        dropDown.selectionAction = { (index: Int, item: String) in
            print("Selected item: \(item)")
            self.selectedFilter = item
            self.filter()
        }
        
        DropDown.appearance().cellHeight = 66
        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 20)
        DropDown.appearance().backgroundColor = UIColor(red: 0.733, green: 0.871, blue: 0.984, alpha: 0.8)
        
        dropDown.show()
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
}
