//
//  StudentRepositoryImpl.swift
//  BreesixPintar
//
//  Created by Rangga Biner on 13/10/24.
//
import Foundation

class StudentRepositoryImpl: StudentRepository {
    private let dataSource: StudentDataSource

    init(dataSource: StudentDataSource) {
        self.dataSource = dataSource
    }

    func fetchAllStudents() async throws -> [Student] {
        return try await dataSource.fetch()
    }

    func addStudent(_ student: Student) async throws {
        try await dataSource.insert(student)
    }

    func updateStudent(_ student: Student) async throws {
        try await dataSource.update(student)
    }

    func deleteStudent(_ student: Student) async throws {
        try await dataSource.delete(student)
    }
}
