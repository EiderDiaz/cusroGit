//
//  datosViewController.swift
//  AgregarATableviewEnTiempoDeEjecucion
//
//  Created by arqmaq11 on 02/05/17.
//  Copyright © 2017 arqmaq11. All rights reserved.
//

import UIKit

class datosViewController: UIViewController {

    var delegado:protocoloDeAltaDeAlumno?=nil
    
    @IBOutlet weak var nombre: UITextField!
    
    
    @IBAction func cancelar(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func guardar(_ sender: UIBarButtonItem) {
        let n = nombre.text
        if (delegado?.guardar(nombre: n!))!{
            dismiss(animated: true, completion: nil)
        }
        else
        {
            let controladoralerta = UIAlertController(title:"Error al guardar",message: "nombre duplicado",preferredStyle: .alert)
            let OKaction = UIAlertAction(title: "aceptarlo", style: .default) { (action:UIAlertAction!) in }
            controladoralerta.addAction(OKaction)
            self.present(controladoralerta, animated: true, completion: nil)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
