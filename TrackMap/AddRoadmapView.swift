import SwiftUI

struct AddRoadmapView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appData: AppData
    
    @State private var title = ""
    @State private var description = ""
    @State private var imageName = "star.fill"
    @State private var showingAIOptions = false
    
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
                
                Section {
                    Button(action: {
                        showingAIOptions = true
                    }) {
                        HStack {
                            Image(systemName: "sparkles")
                                .foregroundColor(.yellow)
                            Text("Create a new roadmap using AI")
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 4)
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
            .sheet(isPresented: $showingAIOptions) {
                AIRoadmapOptionsView(onSelectTemplate: { roadmap in
                    appData.addRoadmap(roadmap)
                    presentationMode.wrappedValue.dismiss()
                })
            }
        }
    }
}

struct AIRoadmapOptionsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appData: AppData
    var onSelectTemplate: (Roadmap) -> Void
    @State private var showingAIGenerator = false
    
    var body: some View {
        NavigationView {
            List {
                Button(action: {
                    showingAIGenerator = true
                }) {
                    HStack {
                        Image(systemName: "sparkles.rectangle.stack")
                            .foregroundColor(.purple)
                            .font(.title2)
                            .frame(width: 40, height: 40)
                        
                        VStack(alignment: .leading) {
                            Text("Custom AI-Generated Roadmap")
                                .font(.headline)
                            Text("Describe what you want to learn and our AI will create a customized roadmap")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .lineLimit(2)
                        }
                    }
                    .padding(.vertical, 5)
                }
                
                Section(header: Text("Pre-built Templates")) {
                    RoadmapTemplateOption(
                        title: "Python Mastery",
                        description: "A hands-on, practical path to master Python programming",
                        imageName: "chevron.left.forwardslash.chevron.right",
                        onSelect: {
                            onSelectTemplate(RoadmapTemplates.createPythonRoadmap())
                        }
                    )
                    
                    RoadmapTemplateOption(
                        title: "Data Science",
                        description: "A deep dive into data science—from data wrangling to impactful visualizations",
                        imageName: "chart.bar.doc.horizontal",
                        onSelect: {
                            onSelectTemplate(RoadmapTemplates.createDataScienceRoadmap())
                        }
                    )
                    
                    RoadmapTemplateOption(
                        title: "Machine Learning & MLOps",
                        description: "Master traditional Machine Learning and operationalize ML models",
                        imageName: "gearshape.2.fill",
                        onSelect: {
                            onSelectTemplate(RoadmapTemplates.createMLAndMLOpsRoadmap())
                        }
                    )
                    
                    RoadmapTemplateOption(
                        title: "Deep Learning & LLMs",
                        description: "Comprehensive guide to deep learning, LLMs, and intelligent agents",
                        imageName: "brain.head.profile",
                        onSelect: {
                            onSelectTemplate(RoadmapTemplates.createDeepLearningLLMsAgentsRoadmap())
                        }
                    )
                }
            }
            .navigationTitle("AI Roadmap Generator")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
            .sheet(isPresented: $showingAIGenerator) {
                AIRoadmapGenerator()
                    .environmentObject(appData)
            }
        }
    }
}
struct RoadmapTemplateOption: View {
    let title: String
    let description: String
    let imageName: String
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.blue)
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                }
            }
            .padding(.vertical, 5)
        }
    }
}
