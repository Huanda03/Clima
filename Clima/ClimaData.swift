//
//  ClimaData.swift
//  Clima
//
//  Created by Mac2 on 02/12/20.
//  Copyright © 2020 Mac2. All rights reserved.
//

import Foundation

struct ClimaData: Decodable{
    let name : String
    let timezone : Int
    let main : Main
    let corrd : Coord
}

struct Main: Decodable {
    let temp: Double
}

struct Coord: Decodable {
    let lon : Double
    let lat : Double
}
