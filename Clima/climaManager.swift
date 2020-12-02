//
//  climaManager.swift
//  Clima
//
//  Created by Mac2 on 02/12/20.
//  Copyright © 2020 Mac2. All rights reserved.
//

import Foundation

struct climaManager {
    let climaURL = "http://api.openweathermap.org/data/2.5/weather?appid=1726f13a5f1807aaeb7d74d47cc0790d&unit=metric&q="
    
    func fetchClima (nombreCiudad: String){
        let urlString = "\(climaURL)\(nombreCiudad)"
        print(urlString)
    }
    
    func realizarSolicitud (urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let tarea = session.dataTask(with: url, completionHandler: handle(data:respuesta:error:))
            tarea.resume()
        }
        
    }
    func handle (data: Data?, respuesta: URLResponse?, error:Error?){
        if error != nil{
            print(error!)
            return
        }
        if let datosSeguros = data {
            let dataString = String(data : datosSeguros, encoding: .utf8)
            print(dataString!)
        }
    }
    
}
