//
//  Product.swift
//  Social Buy
//
//  Created by MCS on 11/10/15.
//  Copyright © 2015 Mobile Consulting Solutions. All rights reserved.
//

import UIKit
import CoreData

class Product: NSManagedObject {
    var id = 0
    var name = ""
    var desc = ""
    var price = 0.0
    var discount = false
    var quantity = 0
}
