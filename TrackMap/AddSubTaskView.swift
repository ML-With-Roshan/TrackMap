//
//  AddSubTaskView.swift
//  TrackMap
//
//  Created by Roshan Sai on 4/19/25.
//

import SwiftUI

struct AddSubTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var subTaskName: String = ""
    var onAdd: (String) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("SubTask Details")) {
                    TextField("SubTask Name", text: $subTaskName)
                }
            }
            .navigationTitle("New SubTask")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Add") {
                    onAdd(subTaskName)
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(subTaskName.isEmpty)
            )
        }
    }
}
