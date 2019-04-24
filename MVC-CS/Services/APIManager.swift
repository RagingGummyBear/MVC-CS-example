//___FILEHEADER___

import Foundation
import UIKit
import PromiseKit

class APIManager {
    // MARK: - Properties

    // MARK: - Functions
    
    func getAllTODOs() -> Promise<[TODOModel]>{
        return Promise { seal in
            firstly {
                URLSession.shared.dataTask(.promise, with: createAllTODOSRequest()).validate()
            // ^^ we provide `.validate()` so that eg. 404s get converted to errors
            }.map {
                try JSONDecoder().decode([TODOModel].self, from: $0.data)
            }.done { result in
                seal.fulfill(result)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    func getTODOsFromUser(userId: Int) -> Promise<[TODOModel]> {
        return Promise { seal in
            firstly {
                URLSession.shared.dataTask(.promise, with: createAllTODOSRequest(from: userId)).validate()
                // ^^ we provide `.validate()` so that eg. 404s get converted to errors
            }.map {
                try JSONDecoder().decode([TODOModel].self, from: $0.data)
            }.done { result in
                seal.fulfill(result)
            }.catch { error in
                seal.reject(error)
            }
            
        }
    }
    
    func createAllTODOSRequest() -> URLRequest {
        var rq = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/todos")!)
        rq.httpMethod = "GET"
        rq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        rq.addValue("application/json", forHTTPHeaderField: "Accept")
        return rq
    }
    
    func createAllTODOSRequest(from userId:Int) -> URLRequest {
        var rq = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/todos?userId=\(userId)")!)
        rq.httpMethod = "GET"
        rq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        rq.addValue("application/json", forHTTPHeaderField: "Accept")
        return rq
    }
    
}
