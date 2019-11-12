//
//  ViewController.swift
//  FirstThreadsHomeWork
//
//  Created by Эмиль Шалаумов on 12.11.2019.
//  Copyright © 2019 Emil Shalaumov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // test
        // spinlocks just for printing correct array counts
        
        //initial count = 5
        let syncArray = SyncArray(with: [1, 2, 3, 4, 5])
        
        let firstQueue = DispatchQueue(label: "com.async.test1")
        let secondQueue = DispatchQueue(label: "com.async.test2")
        var spin1 = true
        var spin2 = true
        
        firstQueue.async {
            for i in 0..<80 {
                syncArray.addElement(with: i)
            }
            spin1 = false
        }
        
        secondQueue.async {
            for i in 0..<80 {
                syncArray.addElement(with: i)
            }
            spin2 = false
        }
        
        //wait while both thread will finish and check count - it has to be 165
        while(spin1 || spin2) { }
        print(syncArray.getCount())
        spin1 = true
        spin2 = true
        
        firstQueue.async {
            for _ in 0..<80 {
                syncArray.removeElement(at: 0)
            }
            spin1 = false
        }
        
        secondQueue.async {
            for _ in 0..<80 {
                syncArray.removeElement(at: 0)
            }
            spin2 = false
        }
        
        //wait again and check count after removing - it has to be 5
        while(spin1 || spin2) { }
        print(syncArray.getCount())
    }


}

