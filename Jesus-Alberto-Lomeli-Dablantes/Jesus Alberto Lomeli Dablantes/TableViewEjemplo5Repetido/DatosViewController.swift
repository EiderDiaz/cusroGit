//
//  DatosViewController.swift
//  TableViewEjemplo5Repetido
//
//  Created by Jesus Alberto Lomeli Dablantes on 02/05/17.
//  Copyright © 2017 Jesus Alberto Lomeli Dablantes. All rights reserved.
//

import UIKit

class DatosViewController: UIViewController ,  UIPickerViewDataSource, UIPickerViewDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var delegado : ProtocoloAltaAlumno? = nil
    let seleccionador=UIImagePickerController()
    var seleccion : Int = 0
    
    var primeraColumna = ["Na","7","8","9","100"]
    var segundaColumna = Array(0...9)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerCalificaciones.dataSource = self
        self.pickerCalificaciones.delegate = self
        seleccionador.delegate = self
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
        
        var calificacion : Int = 0
        
        if primeraColumna[seleccion] == "Na"{
            
            calificacion = 0
        }
        else if primeraColumna[seleccion] == "100" {
           
            calificacion = 100
            
        }
        else{
            calificacion = Int(primeraColumna[seleccion]+pickerCalificaciones.selectedRow(inComponent: 1).description)!
        }
        
        
        
        
        
        if (texto == "") || (datosapellidos == "") {
        
            let controladorAlerta = UIAlertController(title: "Error al Guardar", message: "Campos vacios", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Aceptarlo", style: .default){(action: UIAlertAction!) in}
            
            controladorAlerta.addAction(okAction)
            self.present(controladorAlerta, animated: true, completion: nil)
        }
        else{
            
            if (delegado?.guardar(nombre: texto!, apellidos: datosapellidos!, calificacion: calificacion))! {
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
        
        if component == 0 {
            return primeraColumna.count
        }
        else{
            if (seleccion == 0) || (seleccion == primeraColumna.count-1) {
                return 0
            }
            else {
                
                return segundaColumna.count
            }
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if component == 0{
            return primeraColumna[row]
            
        }
        else {
           
            
            if (seleccion == 0) || (seleccion == primeraColumna.count-1) {

                return nil
            }
            else {
            
            return String(segundaColumna[row])
            }
        }
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        seleccion = pickerCalificaciones.selectedRow(inComponent: 0)
        print(seleccion)
        
        if component == 0 {
            pickerCalificaciones.reloadComponent(1)
        }
        
    }
    
    @IBOutlet weak var pickerCalificaciones: UIPickerView!
    
    @IBOutlet weak var apellidos: UITextField!
    
    @IBAction func botonFoto(_ sender: UIButton) {
        seleccionador.allowsEditing=false
        seleccionador.sourceType = .photoLibrary
        seleccionador.mediaTypes = UIImagePickerController.availableMediaTypes(for: UIImagePickerControllerSourceType.photoLibrary)!
       
    }
   
    
    @IBOutlet weak var dato: UITextField!
    

}
