

import UIKit
import CoreData



class AlumnosTableViewController: UITableViewController, ProtocoloAltaAlumno, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let identificador = "celdaDatos"
    let identificadorSegue = "segueDatos"
    let seleccionador=UIImagePickerController()
    
    var modeloAlumnos : [AlumnoBD] = []
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let guardarContexto = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
 
    func cargarDatos() -> [AlumnoBD]{
        
        do {
            return try contexto.fetch(AlumnoBD.fetchRequest())
            
        } catch  {
            print ("upsi en cargar datos")
        }
        return []
    }
    
  
    @IBOutlet weak var menu: UISegmentedControl!
    
    @IBAction func cambiarEstado(_ sender: UISegmentedControl) {
    
        tableView.reloadData()
        
    
    }
    
    
    func mostrarDatos(){
        
        
        tableView.reloadData()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seleccionador.delegate = self
        
        modeloAlumnos = cargarDatos()
        
        if modeloAlumnos.isEmpty{}
        else{
            
            mostrarDatos()
            
        }


    }
    //Eliminar con animacion
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            //Borrar el renglon del data source
            let alumnoBorrado = modeloAlumnos[indexPath.row]
            contexto.delete(alumnoBorrado)
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            modeloAlumnos = cargarDatos()
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
        }else if editingStyle == .insert{
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modeloAlumnos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identificador , for: indexPath) as! AlumnoTableViewCell
        
        
        //guardar en nuestro array temporal el tipo de ordenamiento del modelo
        switch (menu.selectedSegmentIndex) {
        case 0:
            let miPeticion : NSFetchRequest = AlumnoBD.fetchRequest()
            miPeticion.sortDescriptors = [NSSortDescriptor(key: "apellido", ascending: true)]
            do {
                let resultadoPeticion = try contexto.fetch(miPeticion)
                modeloAlumnos = resultadoPeticion
            } catch {
                print("error en el ordenar nombre")
            }
    
        case 1:
            let miPeticion : NSFetchRequest = AlumnoBD.fetchRequest()
            miPeticion.sortDescriptors = [NSSortDescriptor(key: "calificacion", ascending: false)]
            do {
                let resultadoPeticion = try contexto.fetch(miPeticion)
                modeloAlumnos = resultadoPeticion
            } catch {
                print("error en el ordenar calificacion")
            }
       case 2 :
        let miPeticion : NSFetchRequest = AlumnoBD.fetchRequest()
        miPeticion.sortDescriptors = [NSSortDescriptor(key: "calificacion", ascending: true)]
        do {
            let resultadoPeticion = try contexto.fetch(miPeticion)
            modeloAlumnos = resultadoPeticion
        } catch {
            print("error en el ordenar calificacion")
        }
        default:
        break
        }
        
        
        //desplegamos las cells
       
        cell.labelNombre.text = modeloAlumnos[indexPath.row].nombre
        cell.labelApellidos.text = modeloAlumnos[indexPath.row].apellido
        let calificacion = Int(modeloAlumnos[indexPath.row].calificacion)
        if (calificacion < 70 ) {
            cell.labelCalificacion.textColor=UIColor.red
            cell.labelCalificacion.text = String(modeloAlumnos[indexPath.row].calificacion)
        }
        else{
            cell.labelCalificacion.textColor=UIColor.black
            
            cell.labelCalificacion.text = String(modeloAlumnos[indexPath.row].calificacion)
        }
        //
        
        
        
        return cell
     
    }

    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //preparamos el destino
        if segue.identifier == identificadorSegue {
            let destino = segue.destination as! UINavigationController //navegamos mediante el navigation controller
            let destinoVerdadero = destino.topViewController as! DatosViewController //accedemos a la capa superior 
            destinoVerdadero.delegado = self
            
            
        }
    }
    func guardar(nombre: String, apellidos : String, calificacion : Int) -> Bool {
        
        
        let found = modeloAlumnos.contains(where: {$0.nombre?.caseInsensitiveCompare(nombre) == .orderedSame && $0.apellido?.caseInsensitiveCompare(apellidos) == .orderedSame})
        
       if found{
            return false
        }
        else{
            
            let alumno : AlumnoBD = AlumnoBD (context : contexto)
            
            alumno.nombre = nombre
            alumno.apellido = apellidos
            alumno.calificacion = Int64(calificacion)
            
            do {
                try contexto.save()
            } catch  {
                print("upsi")
            }
        
            modeloAlumnos = cargarDatos()
            guardarContexto()
            mostrarDatos()

            return true
        }

        
    }
    
    @IBOutlet weak var imageView: UIImageView!

    
    
  

}
