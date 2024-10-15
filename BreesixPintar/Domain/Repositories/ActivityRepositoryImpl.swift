//
//  ActivityRepositoryImpl.swift
//  BreesixPintar
//
//  Created by Rangga Biner on 13/10/24.
//

import Foundation
import SwiftData

class ActivityRepositoryImpl: ActivityRepository {
    private let activityDataSource: ActivityDataSource

    init(activityDataSource: ActivityDataSource) {
        self.activityDataSource = activityDataSource
    }

    func fetchAllActivities(_ student: Student) async throws -> [Activity] {
        return student.activities
    }

    func addActivity(_ activity: Activity, for student: Student) async throws {
        student.activities.append(activity)
        try await activityDataSource.insert(activity)
    }

    func updateActivity(_ activity: Activity) async throws {
        try await activityDataSource.update(activity)
    }

    func deleteActivity(_ activity: Activity, from student: Student) async throws {
        student.activities.removeAll { $0.id == activity.id }
        try await activityDataSource.delete(activity)
    }
}
