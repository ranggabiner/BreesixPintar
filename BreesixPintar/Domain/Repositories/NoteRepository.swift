//
//  NoteRepository.swift
//  BreesixPintar
//
//  Created by Rangga Biner on 13/10/24.
//

import Foundation

protocol NoteRepository {
    func fetchAllNotes(_ student: Student) async throws -> [Note]
    func addNote(_ note: Note, for student: Student) async throws
    func updateNote(_ note: Note) async throws
    func deleteNote(_ note: Note, from student: Student) async throws
}
