//
//  ViewController.swift
//  VVDemo
//
//  Created by yuanjilee on 2018/1/25.
//  Copyright © 2018年 yuanjilee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var connectButton: UIButton!
    
    @IBAction func buttonDidClick(_ sender: UIButton) {
        print("connect tap")
        if(VpnManager.shared.vpnStatus == .off){
            VpnManager.shared.connect()
        }else{
            VpnManager.shared.disconnect()
        }
    }


    var status: VPNStatus {
        didSet(o) {
            updateConnectButton()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.status = .off
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(onVPNStatusChanged), name: NSNotification.Name(rawValue: kProxyServiceVPNStatusNotification), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        connectButton.backgroundColor = .red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.status = VpnManager.shared.vpnStatus
    }
    
    @objc func onVPNStatusChanged(){
        self.status = VpnManager.shared.vpnStatus
    }
    
    func updateConnectButton(){
        switch status {
        case .connecting:
            connectButton.setTitle("connecting", for: UIControlState())
        case .disconnecting:
            connectButton.setTitle("disconnect", for: UIControlState())
        case .on:
            connectButton.setTitle("Disconnect", for: UIControlState())
        case .off:
            connectButton.setTitle("Connect", for: UIControlState())
            
        }
        connectButton.isEnabled = [VPNStatus.on,VPNStatus.off].contains(VpnManager.shared.vpnStatus)
        
        
    }
    
}

