//
//  ViewController.swift
//  CoreData2
//
//  Created by arqmac12 on 08/05/17.
//  Copyright © 2017 arqmac12. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let contexto=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let guardarContexto=(UIApplication.shared.delegate as! AppDelegate).saveContext
    
    var modelo:[Persona]=[]
    var indice=0
    
    func mostrarDatos(){
        if !modelo.isEmpty{
        txtNombre.text=modelo[indice].nombre
        txtApellidos.text=modelo[indice].apellidos
        }
    }
    
    func cargarDatos()->[Persona]{
        do {
            indice=0
            return try contexto.fetch(Persona.fetchRequest())
        } catch  {
            print("upsi  en cargar datos")
        }
        return []
    }

    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtApellidos: UITextField!
    
    
    @IBOutlet weak var alPrincipio: UIButton!
    @IBOutlet weak var regresarUno: UIButton!
    @IBOutlet weak var adelantarUno: UIButton!
    @IBOutlet weak var alFinal: UIButton!
    
    
    @IBOutlet weak var contadorRegistros: UILabel!
    
    func estadoBotones(){
        if !modelo.isEmpty || modelo.count>1{
            if (indice==0){
                alPrincipio.isEnabled=false
                regresarUno.isEnabled=false
                alFinal.isEnabled=true
                adelantarUno.isEnabled=true
            }else if (indice>0 && indice<modelo.count-1){
                alPrincipio.isEnabled=true
                regresarUno.isEnabled=true
                alFinal.isEnabled=true
                adelantarUno.isEnabled=true
            }else if (indice==modelo.count-1){
                alFinal.isEnabled=false
                adelantarUno.isEnabled=false
                alPrincipio.isEnabled=true
                regresarUno.isEnabled=true
            }
        }else{
            alPrincipio.isEnabled=false
            adelantarUno.isEnabled=false
            regresarUno.isEnabled=false
            alFinal.isEnabled=false
        }
    
    }
    @IBAction func alPrincipio(_ sender: UIButton) {
        indice=0
        mostrarDatos()
        estadoBotones()
    }
    
    @IBAction func regresarUno(_ sender: UIButton) {
        if indice>0{
            indice=indice-1
            mostrarDatos()
            estadoBotones()
        }
        
        
    }
    
    
    @IBAction func adelantarUno(_ sender: UIButton) {
        if indice<modelo.count-1{
            indice=indice+1
            mostrarDatos()
            estadoBotones()
        }
    }
    
    
    @IBAction func alFinal(_ sender: UIButton) {
        indice=modelo.count-1
        mostrarDatos()
        estadoBotones()
    }
    
    
    @IBAction func guardar(_ sender: UIButton) {
        let datoNombre=txtNombre.text!
        let datoApellidos=txtApellidos.text!
        var persona:Persona = Persona(context: contexto)
        persona.nombre=datoNombre
        persona.apellidos=datoApellidos

        do {
            try contexto.save()
            modelo=cargarDatos()
            estadoBotones()
        } catch  {
            print("upsi en guardar")
        }
        
    }
    
    func cargarDatosFiltro(nombre:String?)->[Persona]{
        if nombre==""{
            indice=0
            return cargarDatos()
        }
        let miPeticion:NSFetchRequest<Persona>=Persona.fetchRequest()
        miPeticion.predicate=NSPredicate(format: "nombre==%@", txtNombre.text!)
        do {
            let resultadosPeticion = try contexto.fetch(miPeticion)
            contadorRegistros.text=String(resultadosPeticion.count)
            return resultadosPeticion
        } catch  {
            print("Upsi en el filtro")
        }
        return []
    }
    
    
    @IBAction func eliminar(_ sender: UIButton) {
        let unaPersona=modelo[indice]
        contexto.delete(unaPersona)
        guardarContexto()
        modelo=cargarDatos()
        
    }
    
    @IBAction func filtrarDatos(_ sender: UIButton) {
        //cargarDatosFiltro(nombre: <#T##String?#>)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        modelo=cargarDatos()
        mostrarDatos()
        estadoBotones()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

