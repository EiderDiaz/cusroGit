//
//  DatosViewController.swift
//  ListaAlumnosMasCoreData
//
//  Created by eiderdiaz on 5/15/17.
//  Copyright © 2017 eiderdiaz. All rights reserved.
//

import UIKit
import CoreData

class DatosViewController: UIViewController,  UIPickerViewDataSource, UIPickerViewDelegate  {
    
    
    
    
    
    
    
    
    
    
    @IBOutlet weak var pickerCalificaciones: UIPickerView!
    @IBOutlet weak var apellidos: UITextField!
    @IBOutlet weak var txtnombre: UITextField!
    var delegate : ProtocoloAlumnos? = nil
    
    var centenas = [0,7,8,9,10]
    var decenas = [0,1,2,3,4,5,6,7,8,9]
    
    
    @IBAction func cancelar(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerCalificaciones.dataSource = self
        self.pickerCalificaciones.delegate = self

        // Do any additional setup after loading the view.
    }
    @IBAction func guarda(_ sender: UIBarButtonItem) {
        let nombre = txtnombre.text
        let apellidos = self.apellidos.text
        let  Indexcentenas = pickerCalificaciones.selectedRow(inComponent: 0)
        let Indexdecenas = pickerCalificaciones.selectedRow(inComponent: 1)
        let centenas  = String(self.centenas[Indexcentenas])
        let decenas = String(self.decenas[Indexdecenas])
        let Stringcalificacion = centenas+decenas
        var calificacion = Int(Stringcalificacion)
        
        if(calificacion! > 100 ){
            calificacion = 100
        }
        if(calificacion! < 70 ){
            calificacion = 0
        }
        
        if (nombre == "") || (apellidos == "") {
            
            let Alerta = UIAlertController(title: "Error al Guardar", message: "Campos vacios", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Aceptarlo", style: .default){(action: UIAlertAction!) in}
            
            Alerta.addAction(okAction)
            self.present(Alerta, animated: true, completion: nil)
        }
        else{
            
            if (delegate?.guardar(nombre: nombre!, apellidos: apellidos!, calificacion: calificacion!))! {
                dismiss(animated: true, completion: nil)
            }
            else {
                
                
                
                let Alerta = UIAlertController(title: "Error al Guardar", message: "Alumno duplicado", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Aceptarlo", style: .default){(action: UIAlertAction!) in}
                
                Alerta.addAction(okAction)
                self.present(Alerta, animated: true, completion: nil)
                
            }
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0){
            return centenas.count
        }
            
        else{
            return decenas.count
        }
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(component == 0){
            return String(centenas[row])
        }
        else{
            return String(decenas[row])
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
