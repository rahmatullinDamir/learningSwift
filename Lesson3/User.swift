//
//  User.swift
//  Lesson3
//
//  Created by Damir Rakhmatullin on 14.01.25.
//

import Foundation
import UIKit

struct User: Hashable, Identifiable {
    let id: UUID = UUID()
    let name: String
    let surname: String
    let age: String
    let image: UIImage?
    
}
