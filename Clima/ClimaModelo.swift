//
//  ClimaModelo.swift
//  Clima
//
//  Created by Mac2 on 15/12/20.
//  Copyright © 2020 Mac2. All rights reserved.
//

import Foundation

struct ClimaModelo {
    let condicionID : Int
    let nombreCiudad : String
    let temperaturaCelcius : Double
    let descripcionClima : String
    
    var obtenerCondicionCLima : String {
        switch condicionID {
        case 200...232:
            return "tormenta"
        case 300...321:
            return "lluvia"
        default:
            return "sol"
        }
    }
}
