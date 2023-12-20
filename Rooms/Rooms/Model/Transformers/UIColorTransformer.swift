//
//  UIColorTransformer.swift
//  Rooms
//
//  Created by Jaime Escobar on 20/12/23.
//

import Foundation
import class UIKit.UIColor

final class UIColorTransformer: ValueTransformer {
    // Returns data
    override func transformedValue(_ value: Any?) -> Any? {
        guard let color = value as? UIColor else { return nil }
        do {
            return try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
        } catch {
            return nil
        }
    }

    // Returns color
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        do {
            return try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)
        } catch {
            return nil
        }
    }
}
