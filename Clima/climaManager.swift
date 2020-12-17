//
//  climaManager.swift
//  Clima
//
//  Created by Mac2 on 02/12/20.
//  Copyright © 2020 Mac2. All rights reserved.
//

import Foundation

protocol ClimaMAnagerDelegate {
    func actualizarClima (clima : ClimaModelo)
    func huboError (cualError : Error)
}

struct climaManager {
    
    var delegado: ClimaMAnagerDelegate?
    
    let climaURL = "https://api.openweathermap.org/data/2.5/weather?appid=1726f13a5f1807aaeb7d74d47cc0790d&lang=es&units=metric"
    
    func fetchClima (nombreCiudad: String){
        let urlString = "\(climaURL)&q=\(nombreCiudad)"
        print(urlString)
        realizarSolicitud(urlString: urlString)
    }
    
    func fetchClima (lat: Double, lon: Double){
        let urlString = "\(climaURL)&lat=\(lat)&lon=\(lon)"
        realizarSolicitud(urlString: urlString)
    }
    
    func realizarSolicitud (urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let tarea = session.dataTask(with: url) { (data, respuesta, error) in
                if error != nil{
                    self.delegado?.huboError(cualError: error!)
                    return
                }
                if let datosSeguros = data {
                    if let clima = self.parseJSON(climaData: datosSeguros){
                        self.delegado?.actualizarClima(clima: clima)
                    }
                }
                
            }
            tarea.resume()
        }
        
    }

    func parseJSON (climaData : Data) -> ClimaModelo? {
        let decoder = JSONDecoder ()
        do {
            let datadecodificada = try decoder.decode(ClimaData.self, from: climaData)
            let id = datadecodificada.weather[0].id
            let nombre = datadecodificada.name
            let descripcion = datadecodificada.weather[0].description
            let temperatura = datadecodificada.main.temp
            let max = datadecodificada.main.temp_max
            let min = datadecodificada.main.temp_min
            
            
            let objCLima = ClimaModelo(condicionID: id, nombreCiudad: nombre, temperaturaCelcius: temperatura, descripcionClima: descripcion, maxima: max, minima: min)
            return objCLima
            
        }catch{
        delegado?.huboError(cualError: error)
            return nil
        }
        
    }
    
}
