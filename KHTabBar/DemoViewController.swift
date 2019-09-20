//
//  DemoViewController.swift
//  KHTabBar
//
//  Created by kaho on 19/09/2019.
//  Copyright © 2019 kaho. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController, KHTabBarDelegate {

    @IBOutlet weak var tabBar: KHTabBar!
    
    var currentVC: UIViewController?
    
    var vcs = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let images1: [UIImage] = {
            var images = [UIImage]()
            for i in 0 ... 11 {
                //anim_tabs_gallery_new_
                if let image = UIImage(named: String(format: "your_test_images1_%05d", i)) {
                    images.append(image)
                }
            }
            return images
        }()
        let images2: [UIImage] = {
            var images = [UIImage]()
            for i in 0 ... 11 {
                //anim_tabs_gallery_new_
                if let image = UIImage(named: String(format: "your_test_images2_%05d", i)) {
                    images.append(image)
                }
            }
            return images
        }()
        let images3: [UIImage] = {
            var images = [UIImage]()
            for i in 0 ... 11 {
                //anim_tabs_gallery_new_
                if let image = UIImage(named: String(format: "your_test_images3_%05d", i)) {
                    images.append(image)
                }
            }
            return images
        }()
        let images4: [UIImage] = {
            var images = [UIImage]()
            for i in 0 ... 11 {
                //anim_tabs_gallery_new_
                if let image = UIImage(named: String(format: "your_test_images4_%05d", i)) {
                    images.append(image)
                }
            }
            return images
        }()
        
        tabBar.items = [
            KHTabBarItem(
                images: images1,
                title: "1",
                selectedIconSize: CGSize(width: 60, height: 54),
                normalIconSize: CGSize(width: 45, height: 42),
                selectedElevation: 2
            ),
            KHTabBarItem(
                images: images2,
                title: "2",
                selectedIconSize: CGSize(width: 60, height: 54),
                normalIconSize: CGSize(width: 45, height: 42),
                selectedElevation: 2
            )
            ,
            KHTabBarItem(
                images: images3,
                title: "3",
                selectedIconSize: CGSize(width: 60, height: 54),
                normalIconSize: CGSize(width: 45, height: 42),
                selectedElevation: 2
            )
            ,
            KHTabBarItem(
                images: images4,
                title: "4",
                selectedIconSize: CGSize(width: 60, height: 54),
                normalIconSize: CGSize(width: 45, height: 42),
                selectedElevation: 2
            )
        ]
        tabBar.font = UIFont.systemFont(ofSize: 10)
        
        tabBar.delegate = self
        
        for _ in tabBar.items {
            let vc = DemoSubViewController()
            vc.view.backgroundColor = UIColor(hue: .random(in: 0...1), saturation: 1, brightness: 1, alpha: 1)
            vcs.append(vc)
        }
        
        switchVC(to: tabBar.selectedIndex)
    }

    func tabBar(didSelectItemAt index: Int) {
        switchVC(to:index)
    }
    
    func switchVC(to index:Int) {
        currentVC?.view.removeFromSuperview()
        
        currentVC = vcs[index]
        if currentVC!.view.frame != view.bounds {
            currentVC!.view.frame = view.bounds
        }
        view.insertSubview(currentVC!.view, at: 0)
    }
}
