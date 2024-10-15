//
//  StudentUseCase.swift
//  BreesixPintar
//
//  Created by Rangga Biner on 12/10/24.
//

import Foundation

protocol StudentUseCase {
    func fetchAllStudents() async throws -> [Student]
    func addStudent(_ student: Student, imageData: Data?) async throws
    func updateStudent(_ student: Student, imageData: Data?) async throws
    func deleteStudent(_ student: Student) async throws
}

