//
//  TelegramLogger.swift
//  Telegram-Logging
//
//  Created by Shayan on 11/27/16.
//  Copyright © 2016 Shayan. All rights reserved.

import Foundation

open class TLLogger {
    
    private var api_url = "https://api.telegram.org/"
    private var api_key : String!
    private var chat_id : String!
    private var debugger = false
    
    private var route : String? {
        get {
            if !debugger {return nil}
            return self.api_url + "bot" + self.api_key
        }
    }
    
    public init(Debugging : Bool = true, token : String, chat_id : String) {
        self.api_key = token
        self.chat_id = chat_id
        self.debugger = Debugging
    }
    
    @discardableResult
    public func isDebugging(_ debugging : Bool? = nil) -> Bool {
        if let flag = debugging {
            self.debugger = flag
        }
        return debugger
    }
    
    public func log(_ text : String, condition : conditions = .none, to to_chat_id : String? = nil){
        var str_condition = ""
        if let temp_condition = self.getCondition(condition: condition) {
            str_condition = "\(temp_condition) "
        }
        
        guard let encoded_text = (str_condition + text).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        let path = "/sendMessage?chat_id=\(to_chat_id ?? self.chat_id! )&text=\(encoded_text)"
        sendRequest(path: path)
    }
    
    private func sendRequest(path : String) {
        guard let tempRoute = self.route else {
            return
        }
        
        let strURL = tempRoute + path
        
        guard let url = URL(string: strURL) else {
            return
        }
        
        let request = URLRequest(url: url)
        let session = URLSession.shared.dataTask(with: request)
        session.resume()
        
    }
    
    public enum conditions {
        case warning, error, message, newUser, log, none
        case custom(Character)
    }
    
    private func getCondition(condition : conditions) -> Character? {
        switch condition {
        case .custom(let chr) :
            return chr
        case .log :
            return "🤖"
        case .error :
            return "😱"
        case .message :
            return "💬"
        case .warning :
            return "⚠️"
        case .newUser :
            return "🎉"
        case .none :
            return nil
        }
    }
    
}
