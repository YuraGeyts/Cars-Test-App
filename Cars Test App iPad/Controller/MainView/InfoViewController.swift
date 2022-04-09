//
//  InfoViewController.swift
//  Cars Test App iPad
//
//  Created by Юра Гейц on 09.04.2022.
//

import UIKit

class InfoViewController: UIViewController {

    var car: Car?
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let car = car else { return }

        numberLabel.text = String(car.number)
        statusLabel.text = "Status: \(car.state)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss, dd.MM.yy"
        dateLabel.text = dateFormatter.string(from: car.date)
    }
    
    @IBAction func dismissButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }

}
