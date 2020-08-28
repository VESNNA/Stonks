//
//  ViewController.swift
//  Stonks
//
//  Created by Nikita Vesna on 28.08.2020.
//  Copyright © 2020 Nikita Vesna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLbl: UITextField!
    @IBOutlet weak var symbolLbl: UITextField!
    @IBOutlet weak var priceLbl: UITextField!
    @IBOutlet weak var priceChangeLbl: UITextField!
    @IBOutlet weak var networkActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var picker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

