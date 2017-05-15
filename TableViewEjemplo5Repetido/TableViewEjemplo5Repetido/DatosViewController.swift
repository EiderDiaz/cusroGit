//
//  DatosViewController.swift
//  TableViewEjemplo5Repetido
//
//  Created by Jesus Alberto Lomeli Dablantes on 02/05/17.
//  Copyright © 2017 Jesus Alberto Lomeli Dablantes. All rights reserved.
//

import UIKit

class DatosViewController: UIViewController ,  UIPickerViewDataSource, UIPickerViewDelegate {
    
    var delegado : ProtocoloAltaAlumno? = nil
    
    var calificaciones = Array(0...100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerCalificaciones.dataSource = self
        self.pickerCalificaciones.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelar(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func guardar(_ sender: UIBarButtonItem) {
        
        let texto = dato.text
        let datosapellidos = apellidos.text
        let datoscalificacion = Int(pickerCalificaciones.selectedRow(inComponent: 0))
        
        
        
        if (texto == "") || (datosapellidos == "") {
        
            let controladorAlerta = UIAlertController(title: "Error al Guardar", message: "Campos vacios", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Aceptarlo", style: .default){(action: UIAlertAction!) in}
            
            controladorAlerta.addAction(okAction)
            self.present(controladorAlerta, animated: true, completion: nil)
        }
        else{
            
            if (delegado?.guardar(nombre: texto!, apellidos: datosapellidos!, calificacion: datoscalificacion))! {
                dismiss(animated: true, completion: nil)
            }
            else {
                
      
                
                let controladorAlerta = UIAlertController(title: "Error al Guardar", message: "Alumno duplicado", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Aceptarlo", style: .default){(action: UIAlertAction!) in}
                
                controladorAlerta.addAction(okAction)
                self.present(controladorAlerta, animated: true, completion: nil)
                
            }
      
        }
       
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return calificaciones.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(calificaciones[row])
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBOutlet weak var pickerCalificaciones: UIPickerView!
    
    @IBOutlet weak var apellidos: UITextField!
    
   
    
    @IBOutlet weak var dato: UITextField!
    

}
