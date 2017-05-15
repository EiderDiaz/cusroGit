

import Foundation

protocol ProtocoloAltaAlumno : class{
    func guardar(nombre : String, apellidos : String, calificacion:Int) -> Bool
}

struct Alumnos {
    let nombre : String
    let apellidos : String
    let calificacion : Int
    
    
}
