//
//  CarsModel.swift
//  Cars Test App
//
//  Created by Юра Гейц on 01.04.2022.
//

import Foundation

struct Cars: Codable {
    var cars: [Car]
}

struct Car: Codable {
    var number: Int
    var date: Date
    var state: String
}
