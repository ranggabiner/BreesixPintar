//
//  Note.swift
//  BreesixPintar
//
//  Created by Rangga Biner on 13/10/24.
//

import Foundation
import SwiftData

@Model
class Note {
    var id: UUID = UUID()
    var note: String
    var createdAt: Date
    var student: Student?
    
    init(id: UUID = UUID(), note: String, createdAt: Date, student: Student? = nil) {
        self.id = id
        self.note = note
        self.createdAt = createdAt
        self.student = student
    }
}
