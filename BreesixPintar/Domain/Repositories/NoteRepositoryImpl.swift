//
//  NoteRepositoryImpl.swift
//  BreesixPintar
//
//  Created by Rangga Biner on 13/10/24.
//

import Foundation
import SwiftData

class NoteRepositoryImpl: NoteRepository {
    private let noteDataSource: NoteDataSource

    init(noteDataSource: NoteDataSource) {
        self.noteDataSource = noteDataSource
    }

    func fetchAllNotes(_ student: Student) async throws -> [Note] {
        return student.notes
    }

    func addNote(_ note: Note, for student: Student) async throws {
        student.notes.append(note)
        try await noteDataSource.insert(note)
    }

    func updateNote(_ note: Note) async throws {
        try await noteDataSource.update(note)
    }

    func deleteNote(_ note: Note, from student: Student) async throws {
        student.notes.removeAll { $0.id == note.id }
        try await noteDataSource.delete(note)
    }
}
