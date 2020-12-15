//
//  ClimaData.swift
//  Clima
//
//  Created by Mac2 on 02/12/20.
//  Copyright © 2020 Mac2. All rights reserved.
//

import Foundation

struct ClimaData: Codable{
    let name : String
    let timezone : Int
    let main : Main
    let coord : Coord
    let weather : [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Coord: Codable {
    let lon : Double
    let lat : Double
}

struct Weather: Codable {
    let id : Int
    let description : String
}
