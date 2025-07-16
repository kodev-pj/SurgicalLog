//
//  Item.swift
//  SurgicalLog
//
//  Created by Ichida Ko on 2025/07/16.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
