import SwiftUI

struct AIRoadmapGenerator: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appData: AppData
    
    @State private var roadmapName = ""
    @State private var roadmapDescription = ""
    @State private var isGenerating = false
    @State private var showingResult = false
    @State private var showingError = false
    @State private var aiPrompt = ""
    @State private var errorMessage = ""
    
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
                    dismissButton: .default(Text("Great!"), action: {
                        // Dismiss view after a small delay
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    })
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
        guard !roadmapName.isEmpty && !aiPrompt.isEmpty else { return }
        
        isGenerating = true
        print("Starting roadmap generation...")
        
        AIService.generateRoadmap(
            name: roadmapName,
            description: roadmapDescription,
            prompt: aiPrompt
        ) { result in
            print("Generator callback received: \(result)")
            
            DispatchQueue.main.async {
                isGenerating = false
                
                switch result {
                case .success(let roadmap):
                    print("Roadmap generated successfully")
                    // Add the roadmap immediately
                    appData.addRoadmap(roadmap)
                    // Then show success alert
                    showingResult = true
                    
                case .failure(let error):
                    print("Roadmap generation error: \(error)")
                    errorMessage = error.localizedDescription
                    showingError = true
                }
            }
        }
        
        print("Generator function called")
    }
}
