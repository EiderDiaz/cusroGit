//
//  AlumnosTableViewController.swift
//  ListaAlumnosMasCoreData
//
//  Created by eiderdiaz on 5/15/17.
//  Copyright © 2017 eiderdiaz. All rights reserved.
//

import UIKit
import CoreData

class AlumnosTableViewController: UITableViewController, ProtocoloAlumnos {
    
    let contexto=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let guardarContexto=(UIApplication.shared.delegate as! AppDelegate).saveContext
    var indice=0
    
    

    var modelo : [Persona] = []
    
    let identificador = "celdaDatos"
    
    let identificadorSegue = "segueDatos"
    
    
    @IBAction func segmentedOnChange(_ sender: UISegmentedControl) {
    tableView.reloadData()
    }
    
    @IBOutlet weak var segmented: UISegmentedControl!
    
    func guardar(nombre: String, apellidos : String, calificacion : Int) -> Bool {
        
        let found = modelo.contains(where: {$0.nombre?.caseInsensitiveCompare(nombre) == .orderedSame && $0.apellido?.caseInsensitiveCompare(apellidos) == .orderedSame})
        
        
        if found{
            
            return false
            
        }
            
        else{
            
            let alumno : Persona = Persona (context: contexto)
                alumno.nombre=nombre
                alumno.apellido=apellidos
                alumno.calificacion = String(calificacion)
            
            
            
            do {
                
                try contexto.save()
                
                modelo=cargarDatos()
                
            } catch  {
                
                print("upsi en guardar")
                
            }
             mostrarDatos()
        return true
        }
       
    }
    
    func cargarDatos()->[Persona]{
        
        do {
        
            
            return try contexto.fetch(Persona.fetchRequest())
            
        } catch  {
            
            print("upsi  en cargar datos")
            
        }
        
        return []
        
    }
        
        
    func mostrarDatos(){
        tableView.reloadData()
    }
        
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    modelo=cargarDatos()
        mostrarDatos()
        
        
    

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return modelo.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identificador , for: indexPath) as! AlumnoTableViewCell
        
        
        
        var arrayControl : [Persona] = []
        
        switch (segmented.selectedSegmentIndex) {
            
        case 0:
            
            arrayControl = modelo.sorted(by: { $0.apellido! < $1.apellido! })
            
            
            
        case 1:
            
            arrayControl = modelo.sorted(by: { $0.calificacion! > $1.calificacion! })
            
            
            
        case 2 :
            
            arrayControl = modelo.sorted(by: { $0.calificacion! < $1.calificacion! })
            
            
            
            
            
        default:
            
            break
            
        }
        
        
        
        cell.labelNombre.text = arrayControl[indexPath.row].nombre
        
        cell.labelApellidos.text = arrayControl[indexPath.row].apellido
        
        let calificacion = arrayControl[indexPath.row].calificacion
        
        if (Int(calificacion!)! < 70 ) {
            
            cell.labelCalificaciones.textColor=UIColor.red
            
            cell.labelCalificaciones.text = arrayControl[indexPath.row].calificacion
            
        }
            
        else{
            
            cell.labelCalificaciones.textColor=UIColor.black
            
            
            
            cell.labelCalificaciones.text = arrayControl[indexPath.row].calificacion
            
        }
        
        //
        
        
        
        
        
        
        
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //preparamos el destino
        
        if segue.identifier == identificadorSegue {
            
            let destino = segue.destination as! UINavigationController //navegamos mediante el navigation controller
            
            let destinoVerdadero = destino.topViewController as! DatosViewController //accedemos a la capa superior
            
            destinoVerdadero.delegate = self
            
            
            
            
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let alumnoBorrado = modelo[indexPath.row]
            contexto.delete(alumnoBorrado)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            modelo = cargarDatos()
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
        }else if editingStyle == .insert{
            
        }
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
