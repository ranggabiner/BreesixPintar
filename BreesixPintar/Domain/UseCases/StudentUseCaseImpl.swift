//
//  StudentUseCaseImpl.swift
//  BreesixPintar
//
//  Created by Rangga Biner on 13/10/24.
//

import Foundation

struct StudentUseCaseImpl: StudentUseCase {
    let repository: StudentRepository
    
    func fetchAllStudents() async throws -> [Student] {
        return try await repository.fetchAllStudents()
    }
    
    func addStudent(_ student: Student, imageData: Data?) async throws {
        let newStudent = student
        newStudent.imageData = imageData
        try await repository.addStudent(newStudent)
    }
    
    func updateStudent(_ student: Student, imageData: Data?) async throws {
        let updatedStudent = student
        updatedStudent.imageData = imageData
        try await repository.updateStudent(updatedStudent)
    }
    
    func deleteStudent(_ student: Student) async throws {
        try await repository.deleteStudent(student)
    }
}

