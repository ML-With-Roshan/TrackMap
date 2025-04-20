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
    
    // Additional context fields
    @State private var learningLevel: LearningLevel = .beginner
    @State private var timeCommitment: TimeCommitment = .casual
    @State private var preferredLearningStyle: LearningStyle = .practical
    
    enum LearningLevel: String, CaseIterable, Identifiable {
        case beginner, intermediate, advanced
        var id: String { self.rawValue }
    }
    
    enum TimeCommitment: String, CaseIterable, Identifiable {
        case casual, moderate, intensive
        var id: String { self.rawValue }
    }
    
    enum LearningStyle: String, CaseIterable, Identifiable {
        case practical, theoretical, mixed
        var id: String { self.rawValue }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Roadmap Basics")) {
                    TextField("Roadmap Name", text: $roadmapName)
                    TextField("Description (optional)", text: $roadmapDescription)
                }
                
                Section(header: Text("Learning Context")) {
                    Picker("Skill Level", selection: $learningLevel) {
                        ForEach(LearningLevel.allCases) { level in
                            Text(level.rawValue.capitalized).tag(level)
                        }
                    }
                    
                    Picker("Time Commitment", selection: $timeCommitment) {
                        ForEach(TimeCommitment.allCases) { commitment in
                            Text(commitment.rawValue.capitalized).tag(commitment)
                        }
                    }
                    
                    Picker("Learning Style", selection: $preferredLearningStyle) {
                        ForEach(LearningStyle.allCases) { style in
                            Text(style.rawValue.capitalized).tag(style)
                        }
                    }
                }
                
                Section(header: Text("AI Prompt")) {
                    TextEditor(text: $aiPrompt)
                        .frame(minHeight: 100)
                        .padding(4)
                        .background(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.3)))
                    
                    Text("Describe what you want to learn in detail. The more specific, the better!")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Section {
                    Button(action: generateRoadmap) {
                        if isGenerating {
                            HStack {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                Text("Generating Roadmap...")
                                    .foregroundColor(.white)
                            }
                        } else {
                            Text("Generate Personalized Roadmap")
                                .foregroundColor(.white)
                        }
                    }
                    .disabled(roadmapName.isEmpty || aiPrompt.isEmpty || isGenerating)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                }
            }
            .navigationTitle("AI Roadmap Generator")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
            .alert(isPresented: $showingError) {
                Alert(
                    title: Text("Roadmap Generation Failed"),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .onChange(of: generatedRoadmap) { newValue in
            if let roadmap = newValue {
                appData.addRoadmap(roadmap)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    private func generateRoadmap() {
        isGenerating = true
        
        // Construct a more detailed prompt
        let enhancedPrompt = """
        Learning Goal: \(aiPrompt)
        Skill Level: \(learningLevel.rawValue.capitalized)
        Time Commitment: \(timeCommitment.rawValue.capitalized)
        Preferred Learning Style: \(preferredLearningStyle.rawValue.capitalized)
        """
        
        AIService.generateRoadmap(
            name: roadmapName,
            description: roadmapDescription.isEmpty
                ? "Personalized roadmap for \(roadmapName)"
                : roadmapDescription,
            prompt: enhancedPrompt
        ) { result in
            DispatchQueue.main.async {
                isGenerating = false
                
                switch result {
                case .success(let roadmap):
                    generatedRoadmap = roadmap
                case .failure(let error):
                    errorMessage = "Failed to generate roadmap: \(error.localizedDescription)"
                    showingError = true
                }
            }
        }
    }
}
