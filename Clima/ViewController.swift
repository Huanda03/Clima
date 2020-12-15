//
//  ViewController.swift
//  Clima
//
//  Created by Mac2 on 02/12/20.
//  Copyright © 2020 Mac2. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, ClimaMAnagerDelegate{
    func huboError(cualError: Error) {
        print(cualError.localizedDescription)
        DispatchQueue.main.async {
            self.ciudadLabel.text = cualError.localizedDescription
        }
        
    }
    
    func actualizarClima(clima: ClimaModelo) {
        print("Desde el ViewController \(clima.condicionID)")
        print(clima.descripcionClima)
        print(clima.temperaturaCelcius)
        
        DispatchQueue.main.async {
            self.temperaturaLabel.text = String(clima.temperaturaCelcius)
            self.ciudadLabel.text = clima.descripcionClima
            self.fondoImage.image = UIImage(named: clima.obtenerCondicionClima)
            self.temperaturaImage.image = UIImage(named: clima.obtenerCondicionClimaIcon)
        }
        
    }
    
    
    var ClimaManager = climaManager()
    
    @IBOutlet weak var buscarTextField: UITextField!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var ciudadLabel: UILabel!
    @IBOutlet weak var temperaturaImage: UIImageView!
    @IBOutlet weak var fondoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ClimaManager.delegado = self
        buscarTextField.delegate = self
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        buscarTextField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(buscarTextField.text!)
        ciudadLabel.text = buscarTextField.text
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
    
    @IBAction func buscarButton(_ sender: UIButton) {
        ciudadLabel.text = buscarTextField.text
        ClimaManager.fetchClima(nombreCiudad: buscarTextField.text!)
    }
    
}

