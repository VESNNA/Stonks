//
//  PageViewController.swift
//  Stonks
//
//  Created by Nikita Vesna on 30.08.2020.
//  Copyright © 2020 Nikita Vesna. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var headersArray = ["Monitor","Stonks"]
    var subheadersArray = ["Watch your favorites stocks","Make profit!"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let firstVC = displayViewController(atIndex: 0) {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    
    func displayViewController(atIndex index: Int) -> ContentViewController? {
        guard
            index >= 0,
            index < headersArray.count,
            let contentVC = storyboard?.instantiateViewController(identifier: "contentVC") as? ContentViewController else { return nil }
        
        contentVC.header = headersArray[index]
        contentVC.subheader = subheadersArray[index]
        contentVC.index = index
        
        return contentVC
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index
        index -= 1
        return displayViewController(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index
        index += 1
        return displayViewController(atIndex: index)
    }
    
}
