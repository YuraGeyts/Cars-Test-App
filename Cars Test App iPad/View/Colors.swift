//
//  Colors.swift
//  Cars Test App iPad
//
//  Created by Юра Гейц on 12.04.2022.
//

import UIKit

struct Colors {
    
    //Colors for tableView
    static var availableColor: UIColor { return UIColor(red: 0.733, green: 0.984, blue: 0.789, alpha: 1)}
    static var hiddenColor: UIColor { return UIColor(red: 0.733, green: 0.871, blue: 0.984, alpha: 1)}
    static var disabledColor: UIColor { return UIColor(red: 0.984, green: 0.914, blue: 0.733, alpha: 1)}
    
    //Colors for filter
    static var availableFilterColor: UIColor { return availableColor}
    static var hiddenFilterColor: UIColor { return UIColor(red: 0.082, green: 0.396, blue: 0.753, alpha: 1)}
    static var disabledFilterColor: UIColor { return disabledColor}
    
    
}
