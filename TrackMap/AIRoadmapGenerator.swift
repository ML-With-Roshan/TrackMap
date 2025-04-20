//
//  AiRoadMapGenerator.swift
//  TrackMap
//
//  Created by Roshan Sai on 4/19/25.
//

import SwiftUI

struct AIRoadmapGenerator: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appData: AppData
    
    @State private var roadmapName = ""
    @State private var roadmapDescription = ""
    @State private var isGenerating = false
    @State private var generatedRoadmap: Roadmap?
    @State private var showingResult = false
    @State private var aiPrompt = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Roadmap Details")) {
                    TextField("Roadmap Name", text: $roadmapName)
                    TextField("Description (optional)", text: $roadmapDescription)
                }
                
                Section(header: Text("AI Instructions")) {
                    Text("Our AI will generate a detailed roadmap with phases, tasks, and subtasks based on what you want to learn.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("What do you want to learn?")
                            .font(.headline)
                        
                        TextEditor(text: $aiPrompt)
                            .frame(minHeight: 150)
                            .padding(4)
                            .background(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.3)))
                        
                        Text("Examples: 'iOS app development with SwiftUI', 'Digital marketing skills', 'Web design fundamentals'")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 5)
                }
                
                Button(action: {
                    generateRoadmap()
                }) {
                    if isGenerating {
                        HStack {
                            ProgressView()
                                .padding(.trailing, 10)
                            Text("Generating your roadmap...")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    } else {
                        Text("Generate Roadmap")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
                .disabled(roadmapName.isEmpty || aiPrompt.isEmpty || isGenerating)
                .listRowBackground(Color.blue)
                .foregroundColor(.white)
                .buttonStyle(PlainButtonStyle())
            }
            .navigationTitle("AI Roadmap Generator")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
            .disabled(isGenerating)
            .alert(isPresented: $showingResult) {
                Alert(
                    title: Text("Roadmap Generated!"),
                    message: Text("Your custom roadmap has been successfully created."),
                    dismissButton: .default(Text("Great!")) {
                        if let roadmap = generatedRoadmap {
                            appData.addRoadmap(roadmap)
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            }
            .alert(isPresented: $showingError) {
                Alert(
                    title: Text("Error"),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    private func generateRoadmap() {
        isGenerating = true
        
        // In development mode, we can use the sample roadmap
        if ProcessInfo.processInfo.environment["PREVIEW"] == "true" {
            // Simulated delay to show the loading state
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                generatedRoadmap = createSampleRoadmap()
                isGenerating = false
                showingResult = true
            }
            return
        }
        
        // In production, use the AI service
        AIService.generateRoadmap(
            name: roadmapName,
            description: roadmapDescription,
            prompt: aiPrompt
        ) { result in
            DispatchQueue.main.async {
                isGenerating = false
                
                switch result {
                case .success(let roadmap):
                    generatedRoadmap = roadmap
                    showingResult = true
                    
                case .failure(let error):
                    errorMessage = "Failed to generate roadmap: \(error.localizedDescription)"
                    showingError = true
                }
            }
        }
    }
    
    // Sample roadmap for development/testing
    private func createSampleRoadmap() -> Roadmap {
        return Roadmap(
            id: UUID(),
            title: roadmapName,
            description: roadmapDescription.isEmpty ? "AI-generated roadmap for \(roadmapName)" : roadmapDescription,
            imageName: "sparkles",
            phases: [
                Phase(name: "Phase 1: Fundamentals", tasks: [
                    Task(name: "Understand Basic Concepts", isCompleted: false, subTasks: [
                        SubTask(name: "Research key terminology", isCompleted: false),
                        SubTask(name: "Complete introductory tutorial", isCompleted: false),
                        SubTask(name: "Practice with simple exercises", isCompleted: false)
                    ]),
                    Task(name: "Set Up Learning Environment", isCompleted: false, subTasks: [
                        SubTask(name: "Install necessary software", isCompleted: false),
                        SubTask(name: "Configure development tools", isCompleted: false)
                    ])
                ]),
                Phase(name: "Phase 2: Core Skills", tasks: [
                    Task(name: "Master Intermediate Techniques", isCompleted: false, subTasks: [
                        SubTask(name: "Study advanced concepts", isCompleted: false),
                        SubTask(name: "Complete practical exercises", isCompleted: false),
                        SubTask(name: "Join online community for support", isCompleted: false)
                    ]),
                    Task(name: "Build Sample Projects", isCompleted: false, subTasks: [
                        SubTask(name: "Create first basic project", isCompleted: false),
                        SubTask(name: "Expand with additional features", isCompleted: false)
                    ])
                ]),
                Phase(name: "Phase 3: Advanced Applications", tasks: [
                    Task(name: "Apply Skills to Real Problems", isCompleted: false, subTasks: [
                        SubTask(name: "Identify complex use cases", isCompleted: false),
                        SubTask(name: "Develop comprehensive solution", isCompleted: false)
                    ]),
                    Task(name: "Refine and Optimize", isCompleted: false, subTasks: [
                        SubTask(name: "Test for performance issues", isCompleted: false),
                        SubTask(name: "Implement best practices", isCompleted: false),
                        SubTask(name: "Seek feedback from experts", isCompleted: false)
                    ])
                ])
            ]
        )
    }
}
