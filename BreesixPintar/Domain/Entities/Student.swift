//
//  Student.swift
//  BreesixCanggih
//
//  Created by Rangga Biner on 12/10/24.
//

import Foundation
import SwiftData


@Model
class Student {
    var id: UUID = UUID()
    @Attribute(.externalStorage) var imageData: Data?
    var fullname: String
    var nickname: String
    var createdAt: Date
    @Relationship(deleteRule: .cascade) var activities: [Activity] = []
    @Relationship(deleteRule: .cascade) var notes: [Note] = []

    init(id: UUID = UUID(), imageData: Data? = nil, fullname: String, nickname: String, createdAt: Date) {
        self.id = id
        self.imageData = imageData
        self.fullname = fullname
        self.nickname = nickname
        self.createdAt = createdAt
    }
}
