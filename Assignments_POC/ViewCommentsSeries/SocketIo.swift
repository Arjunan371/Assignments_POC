//
//  SocketIo.swift
//  Assignments_POC
//
//  Created by Arjunan on 04/03/24.
//

import Foundation
import SocketIO

class SocketIOManager {
    
    static let shared = SocketIOManager()
    
    var socketManager: SocketManager?
    private var socketIOClient: SocketIOClient!
    private var getEventID:String = ""
    
    private init(){
    }
    
    func setSocketConnection(strConnectionID:String) {
        guard let socketURL = URL(string: ApiLink.socketUrl) else {
            return
        }
        socketManager = SocketManager(socketURL: socketURL, config: [.log(false)])
        socketIOClient = socketManager?.defaultSocket
        getEventID = strConnectionID
        socketIOClient.on(clientEvent: .connect) {data, ack in
            log("=====> socket connected")
        }
        socketIOClient.on(clientEvent: .disconnect) {data, ack in
            log("=====> socket disconnect")
        }
        socketIOClient.on(clientEvent: .error) {data, ack in
            let errorStr: String = (data.first as? String) ?? ""
            log("=====> socket error \(errorStr)")
        }
        socketIOClient.on(clientEvent: .websocketUpgrade) {data, ack in
            let errorStr = (data.first as? [String:String]) ?? [:]
            log("=====> websocketUpgrade \(errorStr)")
        }
        establishConnection()
    }
    func receiveMessage(completion: @escaping (Int?) -> Void) {
        socketIOClient.on("\(getEventID)") { data, ack in
            log("=====>  receiveMessage = \(data[0] as? Int)")
            completion(data[0] as? Int)
        }
    }
    func sendMessage(msg: String) {
        //socket.emit("test", with: [msg])
        socketIOClient.emit("test", with: [msg]) {
        }
        //socket.emitWithAck("test", with: [msg])
    }
    
    func establishConnection() {
        
        socketIOClient.connect()
    }
    
    func closeConnection() {
        socketIOClient.disconnect()
    }
    
}

class SocketManagerIO {
    
    var socketManager: SocketManager?
    private var socketIOClient: SocketIOClient?
    
    init(){
        
        setSocketConnection()
    }
    deinit {
        closeConnection()
        socketIOClient = nil
    }
    func setSocketConnection() {
        
        guard let socketURL = URL(string: ApiLink.socketUrl) else {
            return
        }
        socketManager = SocketManager(socketURL: socketURL, config: [.log(false),.forceWebsockets(true)])
        socketIOClient = socketManager?.defaultSocket
        
        socketIOClient?.on(clientEvent: .connect) {data, ack in
            log("=====> socket connected")
        }
        socketIOClient?.on(clientEvent: .disconnect) {data, ack in
            log("=====> socket disconnect")
        }
        socketIOClient?.on(clientEvent: .error) {data, ack in
            let errorStr: String = (data.first as? String) ?? ""
            log("=====> socket error \(errorStr)")
        }
        
        establishConnection()
    }
    func receiveMessage(evantName:String ,completion: @escaping (String) -> Void) {
        log("-------------Start SOCKET DATA------------------->")
        log(evantName)
        
        socketIOClient?.on("\(evantName)") { data, ack in
            log("------------- revecived SOCKET DATA------------------->: \(data)")
             completion((data.first as? String) ?? "")
        }
        
    }
    func sendMessage(msg: String) {
        //socket.emit("test", with: [msg])
        socketIOClient?.emit("test", with: [msg]) {
            log("-------------SOCKET DATA------------------->")
            log("-------------SOCKET DATA------------------->")
        }
        //socket.emitWithAck("test", with: [msg])
    }
    
    func establishConnection() {
        socketIOClient?.connect()
    }
    
    func closeConnection() {
        socketIOClient?.disconnect()
    }
}
