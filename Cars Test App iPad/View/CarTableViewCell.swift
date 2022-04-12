//
//  CarTableViewCell.swift
//  Cars Test App iPad
//
//  Created by Юра Гейц on 06.04.2022.
//

import UIKit

class CarTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var background: UIView!
    
    
    func configure(with car: Car) {
        numberLabel.text = String(car.number)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss, dd.MM.yy"
        dateLabel.text = dateFormatter.string(from: car.date)
        
        switch car.state {
        case "available":
            background.backgroundColor = Colors.availableColor
        case "hidden":
            background.backgroundColor = Colors.hiddenColor
        case "disabled":
            background.backgroundColor = Colors.disabledColor
        default:
            break
        }
    }

}
