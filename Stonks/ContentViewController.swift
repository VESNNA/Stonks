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
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var pageBtn: UIButton!
    
    @IBAction func pageBtnPressed(_ sender: UIButton) {
        switch index {
        case 0:
            let pageVC = parent as! PageViewController
            pageVC.nextVC(atIndex: index)
        case 1:
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: "wasIntroWatched")
            userDefaults.synchronize()
            
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    
    var header = ""
    var subheader = ""
    var imageFile = ""
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerLbl.text = header
        subheaderLbl.text = subheader
        
        pageControl.numberOfPages = 2
        pageControl.currentPage = index
        
        pageBtn.layer.cornerRadius = 15
        pageBtn.clipsToBounds = true
        pageBtn.layer.borderWidth = 2
        
        switch index {
        case 0:
            pageBtn.setTitle("Next", for: .normal)
        case 1:
            pageBtn.setTitle("Open app", for: .normal)
        default:
            break
        }
    }

}
