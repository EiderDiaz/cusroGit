

import UIKit

class AlumnosTableViewController: UITableViewController, ProtocoloAltaAlumno{
    var modelo : [Alumnos] = []
    let identificador = "celdaDatos"
    let identificadorSegue = "segueDatos"
    
    
    
    @IBOutlet weak var menu: UISegmentedControl!
    
    
    
    @IBAction func cambiarEstado(_ sender: UISegmentedControl) {
    
        tableView.reloadData()
        
    
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelo.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identificador , for: indexPath) as! AlumnoTableViewCell
        
        var arrayControl : [Alumnos] = []
        //guardar en nuestro array temporal el tipo de ordenamiento del modelo
        switch (menu.selectedSegmentIndex) {
        case 0:
            arrayControl = modelo.sorted(by: { $0.apellidos < $1.apellidos })
    
        case 1:
            arrayControl = modelo.sorted(by: { $0.calificacion > $1.calificacion })
        
        case 2 :
            arrayControl = modelo.sorted(by: { $0.calificacion < $1.calificacion })
            
            
        default:
        break
        }
        
        
        //desplegamos las cells
       
        cell.labelNombre.text = arrayControl[indexPath.row].nombre
        cell.labelApellidos.text = arrayControl[indexPath.row].apellidos
        let calificacion = Int(arrayControl[indexPath.row].calificacion)
        if (calificacion < 70 ) {
            cell.labelCalificacion.textColor=UIColor.red
            cell.labelCalificacion.text = String(arrayControl[indexPath.row].calificacion)
        }
        else{
            cell.labelCalificacion.textColor=UIColor.black
            
            cell.labelCalificacion.text = String(arrayControl[indexPath.row].calificacion)
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
        
        
        let found = modelo.contains(where: {$0.nombre.caseInsensitiveCompare(nombre) == .orderedSame && $0.apellidos.caseInsensitiveCompare(apellidos) == .orderedSame})
        
        if found{
            return false
        }
        else{
            
            modelo.append(Alumnos(nombre: nombre, apellidos: apellidos, calificacion: calificacion))
            tableView.reloadData()
            return true
        }

        
    }
    
  

}
