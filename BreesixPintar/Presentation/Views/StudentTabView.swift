//
//  StudentTabView.swift
//  BreesixPintar
//
//  Created by Rangga Biner on 12/10/24.
//

import SwiftUI

struct StudentTabView: View {
    @StateObject private var viewModel: StudentTabViewModel
    
    init(useCase: StudentUseCase) {
        _viewModel = StateObject(wrappedValue: StudentTabViewModel(useCase: useCase))
    }
        
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.students, id: \.id) { student in
                    StudentRow(student: student, viewModel: viewModel)
                }
                .onDelete { indexSet in
                    guard let index = indexSet.first else { return }
                    Task {
                        await viewModel.deleteStudent(viewModel.students[index])
                    }
                }
            }
            .navigationTitle("Students")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { viewModel.isAddingStudent = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $viewModel.isAddingStudent) {
                AddStudentView(viewModel: viewModel)
            }
        }
    }
}

struct StudentRow: View {
    let student: Student
    @ObservedObject var viewModel: StudentTabViewModel
    @State private var isEditing = false
    
    var body: some View {
        NavigationLink(destination: StudentProfileView(student: student)) {
            HStack {
                if let imageData = student.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray)
                }
                
                VStack(alignment: .leading) {
                    Text(student.fullname)
                        .font(.headline)
                    Text(student.nickname)
                        .font(.subheadline)
                }
            }
        }
        .contextMenu {
            Button("Edit") { isEditing = true }
            Button("Delete", role: .destructive) {
                Task {
                    await viewModel.deleteStudent(student)
                }
            }
        }
        .sheet(isPresented: $isEditing) {
            EditStudentView(student: student, viewModel: viewModel)
        }
    }
}

struct AddStudentView: View {
    @ObservedObject var viewModel: StudentTabViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showingImagePicker = false
    @State private var showingSourceTypeMenu = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nickname", text: $viewModel.newStudentNickname)
                TextField("Full Name", text: $viewModel.newStudentFullname)
                
                Button(action: {
                    showingSourceTypeMenu = true
                }) {
                    HStack {
                        Text("Select Profile Picture")
                        Spacer()
                        if let image = viewModel.newStudentImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Add Student")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Task {
                            await viewModel.addStudent()
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .actionSheet(isPresented: $showingSourceTypeMenu) {
                ActionSheet(title: Text("Choose Image Source"), buttons: [
                    .default(Text("Camera")) {
                        sourceType = .camera
                        showingImagePicker = true
                    },
                    .default(Text("Photo Library")) {
                        sourceType = .photoLibrary
                        showingImagePicker = true
                    },
                    .cancel()
                ])
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $viewModel.newStudentImage, sourceType: sourceType)
            }
        }
    }
}


struct EditStudentView: View {
    @State var student: Student
    @ObservedObject var viewModel: StudentTabViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showingImagePicker = false
    @State private var showingSourceTypeMenu = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var newImage: UIImage?
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nickname", text: $student.nickname)
                TextField("Full Name", text: $student.fullname)
                
                Button(action: {
                    showingSourceTypeMenu = true
                }) {
                    HStack {
                        Text("Change Profile Picture")
                        Spacer()
                        if let image = newImage ?? (student.imageData.flatMap(UIImage.init(data:))) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Edit Student")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Task {
                            await viewModel.updateStudent(student, newImage: newImage)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .actionSheet(isPresented: $showingSourceTypeMenu) {
                ActionSheet(title: Text("Choose Image Source"), buttons: [
                    .default(Text("Camera")) {
                        sourceType = .camera
                        showingImagePicker = true
                    },
                    .default(Text("Photo Library")) {
                        sourceType = .photoLibrary
                        showingImagePicker = true
                    },
                    .cancel()
                ])
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $newImage, sourceType: sourceType)
            }
        }
    }
}



struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct StudentProfileView: View {
    let student: Student
    
    var body: some View {
        VStack {
            if let imageData = student.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.gray)
            }
            
            Text(student.fullname)
                .font(.title)
            
            Text(student.nickname)
                .font(.headline)
        }
        .navigationBarTitle("Student Profile")
    }
}

