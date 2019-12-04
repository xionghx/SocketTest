//
//  ViewController.swift
//  SocketTest
//
//  Created by Daisy  on 2019/12/4.
//  Copyright © 2019 Ttranssnet. All rights reserved.
//

import UIKit
import SocketIO
class ViewController: UIViewController {

    let manager = SocketManager(socketURL: URL(string: "wss://www.9dwit.com")!, config: ["log":true,"reconnects":true,"forceWebsockets":false,"reconnectAttempts":-1,"reconnectWait":3,"forcePolling":true, "connectParams": [String: Any](),"path":"/front_server_path/websocket"])

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let soceket = manager.defaultSocket
        
        
//        soceket.on(clientEvent: SocketClientEvent.connect) { (data, ackEmt) in
//            print("connet \n ++++++++connet\(data)")
//        }
        
        soceket.on(clientEvent: .connect) {data, ack in
            
            data.forEach { (data) in
                print("socket connected: ??? \(data)")

                guard
                    let data = data as? Data
                    else {
                        return
                }
                
                let message = String(data: data, encoding: .utf8)!

                print("socket connected: \(message)")
                
                
                
            }
                  
           
            
//            print("socket connected\(data)\(ack)")
        }
        //
        let params : [String : Any] = ["roomId":"1","token":"2","userId":"3","role":"operator"]
        soceket.emitWithAck("join", with: [params]).timingOut(after: 5) { (parameters) in
           print("socket connected1\(parameters)")
        }
        
        soceket.on("join"){ data,ack in
            print("jjiijjjjjj====\(data)")
        }
        soceket.on("a"){ data,ack in
            print("jjiijjjjjj====\(data)")
        }
        soceket.on(clientEvent: SocketClientEvent.disconnect) { (data, ackEmt) in
            print("disconnect \n ++++++++disconnect")

        }
        soceket.on(clientEvent: SocketClientEvent.error) { (data, ackEmt) in
            print("++++++++ =error \n \(data)")
        }
        
        
        
        soceket.connect()
        
        
        
    }


}

