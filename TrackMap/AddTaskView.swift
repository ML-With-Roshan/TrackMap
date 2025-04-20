//
//  addTaskView.swift
//  TrackMap
//
//  Created by Roshan Sai on 4/19/25.
//
import SwiftUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var taskName: String = ""
    var onAdd: (String) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Task Name", text: $taskName)
                }
            }
            .navigationTitle("New Task")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Add") {
                    onAdd(taskName)
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(taskName.isEmpty)
            )
        }
    }
}
