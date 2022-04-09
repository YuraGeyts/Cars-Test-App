//
//  CarTableViewCell.swift
//  Cars Test App
//
//  Created by Юра Гейц on 02.04.2022.
//

import UIKit

class CarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    
    func configureCell(with car: Car) {
        numberLabel.text = String(car.number)
        //HH:mm:ss, dd.MM.yy
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss, dd.MM.yy"
        dateLabel.text = dateFormatter.string(from: car.date)
        
        numberLabel.textColor = UIColor(red: 0, green: 0.235, blue: 0.561, alpha: 1)
        dateLabel.textColor = UIColor(red: 0, green: 0.235, blue: 0.561, alpha: 1)
        
        switch car.state {
        case "available":
            cellView.backgroundColor = UIColor(red: 0.733, green: 0.984, blue: 0.789, alpha: 1)
        case "hidden":
            cellView.backgroundColor = UIColor(red: 0.733, green: 0.871, blue: 0.984, alpha: 1)
        case "disabled":
            cellView.backgroundColor = UIColor(red: 0.984, green: 0.914, blue: 0.733, alpha: 1)
        default:
            break
        }
    }

}
