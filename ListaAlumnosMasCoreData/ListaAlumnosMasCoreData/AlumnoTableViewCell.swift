//
//  AlumnoTableViewCell.swift
//  ListaAlumnosMasCoreData
//
//  Created by eiderdiaz on 5/15/17.
//  Copyright © 2017 eiderdiaz. All rights reserved.
//

import UIKit

class AlumnoTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var labelNombre: UILabel!
    @IBOutlet weak var labelApellidos: UILabel!
    @IBOutlet weak var labelCalificaciones: UILabel!
}
