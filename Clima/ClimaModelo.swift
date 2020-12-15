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
    
    var obtenerCondicionClima : String {
        switch condicionID {
        case 200...232:
            return "tormenta"
        case 300...321:
            return "drizzle"
        case 500...531:
            return "lluvia"
        case 600...622:
            return "snow"
        case 800 :
            return "clear"
        case 801...804:
            return "clouds"
        default:
            return "ciudad-dia"
        }
    }
    
    var obtenerCondicionClimaIcon : String {
        switch condicionID {
        case 200...232:
            return "tormenta_icon"
        case 300...321:
            return "drizzle_icon"
        case 500...531:
            return "lluvia_icon"
        case 600...622:
            return "snow_icon"
        case 800 :
            return "sol"
        case 801...804:
            return "nublado_icon"
        default:
            return "clear_icon"
        }
    }
    
}
