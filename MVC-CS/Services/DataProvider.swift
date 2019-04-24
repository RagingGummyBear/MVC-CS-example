//___FILEHEADER___

import Foundation
import UIKit
import PromiseKit

public class DataProvider {

    // MARK: - Properties
    let persistentStorage:PersistentStorage = PersistentStorage()
    let apiManager: APIManager = APIManager()
    
    func getAllTODOs() -> Promise<[TODOModel]> {
        return self.apiManager.getAllTODOs()
    }
    
    func getUserTODOs(userId:Int) -> Promise<[TODOModel]> {
        return self.apiManager.getTODOsFromUser(userId: userId)
    }
    
}
