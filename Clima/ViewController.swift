//
//  ViewController.swift
//  Clima
//
//  Created by Mac2 on 02/12/20.
//  Copyright © 2020 Mac2. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController{

    var locationManager = CLLocationManager()
    var ClimaManager = climaManager()
    
    @IBOutlet weak var minimaLabel: UILabel!
    @IBOutlet weak var maximaLabel: UILabel!
    @IBOutlet weak var buscarTextField: UITextField!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var ciudadLabel: UILabel!
    @IBOutlet weak var temperaturaImage: UIImageView!
    @IBOutlet weak var fondoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        ClimaManager.delegado = self
        
        buscarTextField.delegate = self
    }


    
    @IBAction func buscarButton(_ sender: UIButton) {
        ciudadLabel.text = buscarTextField.text
        ClimaManager.fetchClima(nombreCiudad: buscarTextField.text!)
    }
    
    @IBAction func ubicacionButton(_ sender: UIButton) {
        locationManager.requestLocation()
        
    }
    
}

extension ViewController: ClimaMAnagerDelegate{
    func huboError(cualError: Error) {
        print(cualError.localizedDescription)
        DispatchQueue.main.async {
            self.ciudadLabel.text = "Verifique que el nobre sea correcto"
        }
        
    }
    
    func actualizarClima(clima: ClimaModelo) {
        print("Desde el ViewController \(clima.condicionID)")
        print(clima.descripcionClima)
        print(clima.temperaturaCelcius)
        
        DispatchQueue.main.async {
            self.temperaturaLabel.text = String(clima.temperaturaCelcius)
            self.ciudadLabel.text = "En \(clima.nombreCiudad) hay \(clima.descripcionClima)"
            self.fondoImage.image = UIImage(named: clima.obtenerCondicionClima)
            self.temperaturaImage.image = UIImage(named: clima.obtenerCondicionClimaIcon)
            self.minimaLabel.text = String(clima.minima)
            self.maximaLabel.text = String(clima.maxima)
        }
        
    }
    
}

extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Ubicacion obtenida")
        if let ubicacion = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = ubicacion.coordinate.latitude
            let lon = ubicacion.coordinate.longitude
            print("Latitud: \(lat) Longitud: \(lon)")
            ClimaManager.fetchClima(lat: lat, lon: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}

extension ViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        buscarTextField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(buscarTextField.text!)
        //ciudadLabel.text = buscarTextField.text
        ClimaManager.fetchClima(nombreCiudad: buscarTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if buscarTextField.text != ""{
            return true
        }else{
            buscarTextField.placeholder = "Ingrese una ciudad..."
            print("Por favor escriba algo")
            return false
        }
    }
    
}
