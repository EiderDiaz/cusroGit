

import UIKit

class AlumnoTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

    @IBOutlet weak var labelNombre: UILabel!
    @IBOutlet weak var labelApellidos: UILabel!
    @IBOutlet weak var labelCalificacion: UILabel!
    @IBOutlet weak var labelImage: UIImageView!
    
  
    
       
}
