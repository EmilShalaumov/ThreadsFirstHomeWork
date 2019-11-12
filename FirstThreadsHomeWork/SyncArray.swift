//
//  ArrayExtension.swift
//  FirstThreadsHomeWork
//
//  Created by Эмиль Шалаумов on 12.11.2019.
//  Copyright © 2019 Emil Shalaumov. All rights reserved.
//

import Foundation

//thread-safe collection implementation
class SyncArray<Element:Any> {
    
    private var sourceArray: Array<Element>
    let syncQueue = DispatchQueue(label: "com.queue.sync")
    
    init(with array: Array<Element>) {
        self.sourceArray = array
    }
    
    func addElement(with value: Element) {
        syncQueue.sync {
            sourceArray.append(value)
        }
    }
    
    func removeElement(at index: Int) {
        syncQueue.sync {
            _ = sourceArray.remove(at: index)
        }
    }
    
    func getCount() -> Int {
        return sourceArray.count
    }
    
}
