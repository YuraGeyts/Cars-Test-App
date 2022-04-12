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
        dropDown.direction = .bottom
        dropDown.dataSource = FilterComponents.filterDataSource
        
        dropDown.cellNib = UINib(nibName: "FilterCell", bundle: nil)
        
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? FilterCell else { return }
            let filterComponent = FilterComponents.allFilters[index]
            
            switch filterComponent {
            case .noFilter:
                cell.colorImage.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            case .available:
                cell.colorImage.tintColor = Colors.availableFilterColor
            case .hidden:
                cell.colorImage.tintColor = Colors.hiddenFilterColor
            case .disabled:
                cell.colorImage.tintColor = Colors.disabledFilterColor
            }
        }
        
        dropDown.selectionAction = { (index: Int, item: String) in
            self.selectedFilter = FilterComponents.allFilters[index]
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
        
        if selectedFilter == FilterComponents.noFilter {
            isFiltering = false
        } else {
            isFiltering = true
            print(selectedFilter)
            //ChangeButtonText navigationBar.topItem?.title = selectedFilter
            let selectedState = selectedFilter.rawValue.lowercased()
            
            guard let cars = cars else { return }
            
            for car in cars {
                if car.state == selectedState {
                    filteredCars.append(car)
                }
            }
        }
        filterButton.setTitle(selectedFilter.rawValue, for: .normal)
        carsTableView.reloadData()
    }
}
