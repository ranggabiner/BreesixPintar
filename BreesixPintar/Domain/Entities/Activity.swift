//
//  Activity.swift
//  BreesixCanggih
//
//  Created by Rangga Biner on 12/10/24.
//

import Foundation
import SwiftData

@Model
class Activity {
    var id: UUID = UUID()
    var activity: String
    var isIndependent: Bool?
    var createdAt: Date
    var student: Student?
 
    init(id: UUID = UUID(), activity: String, isIndependent: Bool? = nil, createdAt: Date, student: Student? = nil) {
        self.id = id
        self.activity = activity
        self.isIndependent = isIndependent
        self.createdAt = createdAt
        self.student = student
    }
    
}
