//
//  BreesixPintarApp.swift
//  BreesixPintar
//
//  Created by Rangga Biner on 12/10/24.
//

import SwiftUI
import SwiftData

@main
struct BreesixPintarApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Student.self, Activity.self, Note.self)
        } catch {
            fatalError("Failed to create ModelContainer for Student and Activity: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            let context = container.mainContext
            
            let studentDataSource = StudentDataSourceImpl(context: context)
            let studentRepository = StudentRepositoryImpl(dataSource: studentDataSource)
            let studentUseCase = StudentUseCaseImpl(repository: studentRepository)
            
            MainTabView(studentUseCase: studentUseCase, context: context)
                .modelContainer(container)
        }
    }
}

struct MainTabView: View {
    let studentUseCase: StudentUseCase
    let context: ModelContext
    
    var body: some View {
        TabView {
            StudentTabView(useCase: studentUseCase)
                .tabItem {
                    Label("Students", systemImage: "person.3")
                }
            
        }
    }
}
