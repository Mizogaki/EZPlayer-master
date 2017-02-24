//
//  ParamsViewController.swift
//  EZPlayerExample
//
//  Created by yangjun zhu on 2016/12/28.
//  Copyright © 2016年 yangjun zhu. All rights reserved.
//

import UIKit
import EZPlayer
class ParamsViewController: UIViewController {

    @IBOutlet weak var dlView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func playButtonAction(_ sender: Any) {

         MediaManager.sharedInstance.playEmbeddedVideo(url:URL.Test.localMP4_1, embeddedContentView: self.dlView)
   }


    override var shouldAutorotate : Bool {
       return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return .landscape
        }else {
            return .portrait
        }
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        if UIDevice.current.userInterfaceIdiom == .pad {
            return .landscapeRight
        }else {
            return .portrait
        }
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
