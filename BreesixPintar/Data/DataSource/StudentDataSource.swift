//
//  StudentDataSource.swift
//  BreesixCanggih
//
//  Created by Rangga Biner on 12/10/24.
//

import Foundation

protocol StudentDataSource {
    func fetch() async throws -> [Student]
    func insert(_ student: Student) async throws
    func update(_ student: Student) async throws
    func delete(_ student: Student) async throws
}
