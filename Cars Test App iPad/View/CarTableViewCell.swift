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
            background.backgroundColor = UIColor(red: 0.733, green: 0.984, blue: 0.789, alpha: 1)
        case "hidden":
            background.backgroundColor = UIColor(red: 0.733, green: 0.871, blue: 0.984, alpha: 1)
        case "disabled":
            background.backgroundColor = UIColor(red: 0.984, green: 0.914, blue: 0.733, alpha: 1)
        default:
            break
        }
    }

}
