//
//  Room.swift
//  Rooms
//
//  Created by Jaime Escobar on 20/12/23.
//

import Foundation
import SwiftData
import class UIKit.UIColor

@Model
final class Room {
    var name: String
    @Attribute(.transformable(by: UIColorTransformer.self))
    var color: UIColor

    init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
}
