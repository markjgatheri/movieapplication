//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Apple on 08/04/2017.
//  Copyright © 2017 Strathmore. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var iconMovie: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
