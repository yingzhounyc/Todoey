//
//  Item.swift
//  Todoey
//
//  Created by Ying Zhou on 1/21/19.
//  Copyright © 2019 3cslab.com. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCAtegory = LinkingObjects(fromType: Category.self, property: "items")
}

