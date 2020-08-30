//
//  ContentViewController.swift
//  Stonks
//
//  Created by Nikita Vesna on 30.08.2020.
//  Copyright © 2020 Nikita Vesna. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var subheaderLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var header = ""
    var subheader = ""
    var imageFile = ""
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerLbl.text = header
        subheaderLbl.text = subheader
        //imageView.image = UIImage(named: <#T##String#>)
    }

}
