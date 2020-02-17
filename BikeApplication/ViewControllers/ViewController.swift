//
//  ViewController.swift
//  BikeApplication
//
//  Created by Sam Perry on 17/02/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    var videoPlay:AVPlayer?
    var videoPlayLayer:AVPlayerLayer?
    
    @IBOutlet weak var RegisterBtn: UIButton!
    
    @IBOutlet weak var LoginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        frontEndSetUp()
    }
    
    func frontEndSetUp(){
        Utilities.styleFilledButton(RegisterBtn)
        Utilities.styleHollowButton(LoginBtn)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // set up background video
        setUpBg()
    }
    func setUpBg(){
       let bundlePath = Bundle.main.path(forResource: "bike", ofType: "mp4")
        
        guard bundlePath != nil else {
            return
        }
        let url = URL(fileURLWithPath: bundlePath!)
        

        let avItem = AVPlayerItem(url:url)
        
         videoPlay = AVPlayer(playerItem: avItem)
        
        // Adjust the size and frame
        videoPlayLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoPlayLayer!, at: 0)
        
        // Add it to the view and play it
        videoPlayLayer?.player?.playImmediately(atRate: 0.3)
    }
    
    @IBAction func LoginBtnTap(_ sender: Any) {
        
    }
    
    @IBAction func RegisterBtnTap(_ sender: Any) {
        
    }
}

