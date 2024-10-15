//
//  StudentRepository.swift
//  BreesixPintar
//
//  Created by Rangga Biner on 12/10/24.
//

import Foundation

protocol StudentRepository {
    func fetchAllStudents() async throws -> [Student]
    func addStudent(_ student: Student) async throws
    func updateStudent(_ student: Student) async throws
    func deleteStudent(_ student: Student) async throws
}
