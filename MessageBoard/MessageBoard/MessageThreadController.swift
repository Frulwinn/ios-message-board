//  Copyright © 2019 Frulwinn. All rights reserved.

import Foundation

enum PushMethod: String {
    case post = "POST"
    case put = "PUT"
}

class MessageThreadController {
    //call MessageThreadController.baseURL
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!

    var messageThreads: [MessageThread] = []
    
    func createMessageThread(withTitle title: String, identifier: String) -> MessageThread {
        let messageThread = MessageThread(title: title, identifier: identifier)
        return messageThread
    }

    func put(messageThread: MessageThread, using method: PushMethod, completion: @escaping(Error?) -> Void) {
        var url = MessageThreadController.baseURL
        if method == .put {
            url.appendPathComponent(messageThread.identifier)
        }
        
        url.appendPathExtension("https://lambda-message-board.firebaseio.com/695398C4-498C-40A8-AA76-CB2B20DFD9FA/.json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(messageThread)
        } catch {
            print(error)
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error)  in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            completion(nil)
            }.resume()
    }
}
