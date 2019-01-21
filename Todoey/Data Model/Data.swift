//
//  Data.swift
//  Todoey
//
//  Created by Ying Zhou on 1/21/19.
//  Copyright © 2019 3cslab.com. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object{
    @objc dynamic var name : String = ""
    @objc dynamic var age: Int = 0
    
}
