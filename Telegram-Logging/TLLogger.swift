//
//  TelegramLogger.swift
//  Telegram-Logging
//
//  Created by Shayan on 11/27/16.
//  Copyright © 2016 Shayan. All rights reserved.

import Foundation

public class TLLogger {
    
    private var api_key : String!
    private var api_url : String!
    private var chat_id : String!
    private var debugger = false
    
    public init(Debugging : Bool) {
        self.api_key = ""
        self.api_url = ""
        self.debugger = Debugging
    }
    
    public func setup(BOT_KEY : String, CHAT_ID : String) {
        if !BOT_KEY.isEmpty {
            self.api_key = BOT_KEY
            self.chat_id = CHAT_ID
            
            self.api_url = "https://api.telegram.org/bot\(self.api_key!)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let path = "/getMe"
            let url = URL(string: self.api_url + path as String)
            let request = URLRequest(url: url!)
            let session = URLSession.shared.dataTask(with: request, completionHandler: { (Data, URLResponse, Error) in
                if Error == nil {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: Data!, options: .allowFragments) as? [String:AnyObject] {
                            
                            if let ok = json["ok"] as? NSNumber, ok == 1, let result = json["result"] as? Dictionary<String,AnyObject>{
                                
                                if let name = result["username"] as? String, self.debugger {
                                print("TLLogger has been activated. \n Bot's username: \(name)")
                                    if (self.debugger) {
                                        self.sendMessage("✚ New Session Started")
                                    }
                                }
                            }
                        }
                    } catch {
                        print("json error")
                    }
                } else {
                    print("\(self.api_url)")
                }
            })
            session.resume()
        }
    }
    
    public func log(_ text : String){
        if (debugger) {
        sendMessage("🤖 \(text)")
        }
    }
    
    private func sendMessage(_ text : String){
            let path = "/sendMessage?chat_id=\(self.chat_id!)&text=\(text)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            sendRequest(path: path!)
    }
    
    public func reportNewDownload(_ reportLocation : Bool = false, _ text : String = "🎈 New Download"){
        if UserDefaults.standard.value(forKey: "TLLDidOpen") == nil {
                if reportLocation {
                    getLocation()
                } else {
                UserDefaults.standard.set(true, forKey: "TLLDidOpen")
                sendMessage(text)
            }
        }
    }
    
    private func getLocation() {
        let url = URL(string : "http://ip-api.com/json".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        print(url!)
        let request = URLRequest(url : url!)
        let session = URLSession.shared.dataTask(with : request, completionHandler : {
        (Data, URLResponse, Error) in
        if Error == nil {
            do {
                if let json = try JSONSerialization.jsonObject(with  : Data!, options: .allowFragments) as? [String : AnyObject] {
                    if let city = json["city"] as? String, let country = json["country"] as? String {
                        self.reportNewDownload(false,"🎈 New Download From \(country), \(city)")
                    }
                }
            } catch {
                print("JSONSerialization Error")
                }
        } else {
            print("error")
            }
        })
        session.resume()
    }
    
    private func sendRequest(path : String) {
        let url = URL(string: self.api_url + path as String)
        let request = URLRequest(url: url!)
        let session = URLSession.shared.dataTask(with: request)
        session.resume()
        
    }
}
