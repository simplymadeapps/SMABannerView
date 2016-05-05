//
//  ViewController.swift
//  SMABannerView
//
//  Created by Bill Burgess on 5/5/16.
//  Copyright © 2016 Simply Made Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var simpleBannerView: SMABannerView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func showSimpleButtonPressed() {
        if simpleBannerView == nil {
            simpleBannerView = SMABannerView(title: "Simple Title", message: "Simple Message to display", view: self.view)
            simpleBannerView?.backgroundColor = UIColor.blueColor()
            simpleBannerView?.titleColor = UIColor.whiteColor()
            simpleBannerView?.messageColor = UIColor.whiteColor()
        }
        
        simpleBannerView?.show()
    }
    
    @IBAction func hideSimpleButtonPressed() {
        simpleBannerView?.hide()
        simpleBannerView = nil
    }
    
    @IBAction func showBannerWithDuration() {
        let banner = SMABannerView(title: "Banner View", message: "This banner will dismiss automatically.", view: self.view)
        banner.backgroundColor = UIColor.redColor()
        banner.titleColor = UIColor.whiteColor()
        banner.messageColor = UIColor.whiteColor()
        
        banner.show(5) { 
            print("This is the dismiss completion block")
        }
    }
}

