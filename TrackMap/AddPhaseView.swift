import SwiftUI

struct AddPhaseView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var phaseName: String = ""
    var onAdd: (String) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Phase Details")) {
                    TextField("Phase Name", text: $phaseName)
                }
            }
            .navigationTitle("New Phase")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Add") {
                    onAdd(phaseName)
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(phaseName.isEmpty)
            )
        }
    }
}
