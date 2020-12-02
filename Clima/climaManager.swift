//
//  climaManager.swift
//  Clima
//
//  Created by Mac2 on 02/12/20.
//  Copyright © 2020 Mac2. All rights reserved.
//

import Foundation

struct climaManager {
    let climaURL = "https://api.openweathermap.org/data/2.5/weather?appid=1726f13a5f1807aaeb7d74d47cc0790d&units=metric&q="
    
    func fetchClima (nombreCiudad: String){
        let urlString = "\(climaURL)\(nombreCiudad)"
        print(urlString)
        realizarSolicitud(urlString: urlString)
    }
    
    func realizarSolicitud (urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let tarea = session.dataTask(with: url) { (data, respuesta, error) in
                if error != nil{
                    print(error!)
                    return
                }
                if let datosSeguros = data {
                    self.parseJSON(climaData: datosSeguros)
                }            }
            tarea.resume()
        }
        
    }

    func parseJSON (climaData : Data){
        let decoder = JSONDecoder ()
        do {
            let datadecodificada = try decoder.decode(ClimaData.self, from: climaData)
            print(datadecodificada.name)
            print(datadecodificada.timezone)
            print(datadecodificada.main.temp)
        }catch{
            print(error)
        }
        
    }
    
}
