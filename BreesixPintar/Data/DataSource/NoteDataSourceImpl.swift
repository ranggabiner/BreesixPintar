//
//  NoteDataSourceImpl.swift
//  BreesixPintar
//
//  Created by Rangga Biner on 13/10/24.
//

import Foundation
import SwiftData

class NoteDataSourceImpl: NoteDataSource {
    private let modelContext: ModelContext

    init(context: ModelContext) {
        self.modelContext = context
    }

    func fetch() async throws -> [Note] {
        let descriptor = FetchDescriptor<Note>(sortBy: [SortDescriptor(\.createdAt, order: .reverse)])
        let notes = try modelContext.fetch(descriptor)
        return notes
    }

    func insert(_ notes: Note) async throws {
        modelContext.insert(notes)
        try modelContext.save()
    }

    func update(_ notes: Note) async throws {
        try modelContext.save()
    }

    func delete(_ notes: Note) async throws {
        modelContext.delete(notes)
        try modelContext.save()
    }
}
