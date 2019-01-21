//
//  Category.swift
//  Todoey
//
//  Created by Ying Zhou on 1/21/19.
//  Copyright © 2019 3cslab.com. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
