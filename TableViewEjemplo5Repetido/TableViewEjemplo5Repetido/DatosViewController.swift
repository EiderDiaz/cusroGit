import UIKit

class DatosViewController: UIViewController ,  UIPickerViewDataSource, UIPickerViewDelegate {
    
    var delegado : ProtocoloAltaAlumno? = nil
    
    var centenas = [0,7,8,9,10]
    var decenas = [0,1,2,3,4,5,6,7,8,9]
    
    
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
        let  Indexcentenas = pickerCalificaciones.selectedRow(inComponent: 0)
        let Indexdecenas = pickerCalificaciones.selectedRow(inComponent: 1)
        let centenas  = String(self.centenas[Indexcentenas])
        let decenas = String(self.decenas[Indexdecenas])
        var Stringcalificacion = centenas+decenas
        var calificacion = Int(Stringcalificacion)
        print(Stringcalificacion)
        if(calificacion! > 100 ){
            calificacion = 100
        }
        if(calificacion! < 70 ){
            calificacion = 0
        }

        
        
        
        
        if (texto == "") || (datosapellidos == "") {
        
            let controladorAlerta = UIAlertController(title: "Error al Guardar", message: "Campos vacios", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Aceptarlo", style: .default){(action: UIAlertAction!) in}
            
            controladorAlerta.addAction(okAction)
            self.present(controladorAlerta, animated: true, completion: nil)
        }
        else{
            
            if (delegado?.guardar(nombre: texto!, apellidos: datosapellidos!, calificacion: calificacion!))! {
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
    
    @IBOutlet weak var pickerCalificaciones: UIPickerView!
    
    @IBOutlet weak var apellidos: UITextField!
    
   
    
    @IBOutlet weak var dato: UITextField!
    

}

