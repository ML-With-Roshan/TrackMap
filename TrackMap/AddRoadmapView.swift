import SwiftUI

struct AddRoadmapView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appData: AppData
    
    @State private var title = ""
    @State private var description = ""
    @State private var imageName = "star.fill"
    
    let systemImages = ["star.fill", "brain.head.profile", "book.fill", "laptopcomputer", "swift", "gamecontroller.fill", "paintbrush.fill", "music.note", "globe", "heart.fill"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Roadmap Details")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                }
                
                Section(header: Text("Icon")) {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
                        ForEach(systemImages, id: \.self) { image in
                            Image(systemName: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .padding(10)
                                .background(imageName == image ? Color.blue.opacity(0.3) : Color.clear)
                                .cornerRadius(10)
                                .onTapGesture {
                                    imageName = image
                                }
                        }
                    }
                }
            }
            .navigationTitle("New Roadmap")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Create") {
                    let newRoadmap = RoadmapTemplates.createEmptyRoadmap(
                        withTitle: title.isEmpty ? "New Roadmap" : title,
                        description: description.isEmpty ? "Your custom learning roadmap" : description,
                        imageName: imageName
                    )
                    appData.addRoadmap(newRoadmap)
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(title.isEmpty)
            )
        }
    }
}
