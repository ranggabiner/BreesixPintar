//
//  StudentTabViewModel.swift
//  BreesixPintar
//
//  Created by Rangga Biner on 13/10/24.
//

import Foundation
import SwiftUI

class StudentTabViewModel: ObservableObject {
    @Published var students: [Student] = []
    @Published var newStudentNickname: String = ""
    @Published var newStudentFullname: String = ""
    @Published var newStudentImage: UIImage?
    @Published var isAddingStudent: Bool = false
    @Published var editingStudent: Student?
    
    private let useCase: StudentUseCase
    
    init(useCase: StudentUseCase) {
        self.useCase = useCase
        Task {
            await fetchStudents()
        }
    }
    
    func fetchStudents() async {
        do {
            let fetchedStudents = try await useCase.fetchAllStudents()
            DispatchQueue.main.async {
                self.students = fetchedStudents
            }
        } catch {
            print("Error fetching students: \(error)")
        }
    }
    
    func addStudent() async {
        guard !newStudentNickname.isEmpty, !newStudentFullname.isEmpty else { return }
        
        let newStudent = Student(fullname: newStudentFullname, nickname: newStudentNickname, createdAt: Date())
        
        do {
            try await useCase.addStudent(newStudent, imageData: newStudentImage?.jpegData(compressionQuality: 0.8))
            await fetchStudents()
            DispatchQueue.main.async {
                self.newStudentNickname = ""
                self.newStudentFullname = ""
                self.newStudentImage = nil
                self.isAddingStudent = false
            }
        } catch {
            print("Error adding student: \(error)")
        }
    }
    
    func updateStudent(_ student: Student, newImage: UIImage?) async {
        do {
            try await useCase.updateStudent(student, imageData: newImage?.jpegData(compressionQuality: 0.8))
            await fetchStudents()
            DispatchQueue.main.async {
                self.editingStudent = nil
            }
        } catch {
            print("Error updating student: \(error)")
        }
    }
    
    func deleteStudent(_ student: Student) async {
        do {
            try await useCase.deleteStudent(student)
            await fetchStudents()
        } catch {
            print("Error deleting student: \(error)")
        }
    }
}
