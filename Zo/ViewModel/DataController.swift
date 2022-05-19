//
//  DataController.swift
//  Zo
//
//  Created by Brian Heralall on 4/21/22.
//

import Foundation
import SwiftUI
import CoreData

/** Combination of both Core Data and SwiftUI**/

class DataController: NSObject, ObservableObject {
    
    /** Container that encapsulates the Core Data stack in Zo, and mirrors select persistent stores to a CloudKit private database. **/
    let container = NSPersistentCloudKitContainer(name: "DataModel")
    
    
    /** Once the persistent container has been initialized, you need to execute loadPersistentStores to instruct the container to load the persistent stores and complete the creation of the Core Data stack.
     Once the completion handler has fired, the stack is fully initialized and is ready for use. The completion handler will be called once for each persistent store that is created.**/
    override init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("\(error)")
            }
        }
        
    }
}

/** An interface to the user’s defaults database, where you store key-value pairs persistently across launches of your app. **/
let shareDefault = UserDefaults(suiteName: "group.zoapp")!
