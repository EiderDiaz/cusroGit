//
//  ProtocoloAlumno.swift
//  ListaAlumnosMasCoreData
//
//  Created by eiderdiaz on 5/15/17.
//  Copyright © 2017 eiderdiaz. All rights reserved.
//

import Foundation



protocol ProtocoloAlumnos : class{
    
    func guardar(nombre : String, apellidos : String, calificacion:Int) -> Bool
    
}



struct Alumnos {
    
    let nombre : String
    
    let apellidos : String
    
    let calificacion : Int
    
    
    
    
    
}
