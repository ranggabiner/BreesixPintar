//
//  ActivityDataSource.swift
//  BreesixPintar
//
//  Created by Rangga Biner on 13/10/24.
//

import Foundation

protocol ActivityDataSource {
    func fetch() async throws -> [Activity]
    func insert(_ activity: Activity) async throws
    func update(_ activity: Activity) async throws
    func delete(_ activity: Activity) async throws
}
