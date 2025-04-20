import SwiftUI

class AppData: ObservableObject {
    @Published var roadmaps: [Roadmap] = []
    
    init() {
        // Load saved roadmaps from UserDefaults
        if let savedRoadmaps = loadRoadmaps() {
            self.roadmaps = savedRoadmaps
        }
        
        // If no roadmaps exist (first launch), add the default roadmaps
        if self.roadmaps.isEmpty {
            self.roadmaps.append(RoadmapTemplates.createPythonRoadmap())
            self.roadmaps.append(RoadmapTemplates.createDataScienceRoadmap())
            self.roadmaps.append(RoadmapTemplates.createMLAndMLOpsRoadmap())
            self.roadmaps.append(RoadmapTemplates.createDeepLearningLLMsAgentsRoadmap())
            saveRoadmaps()
        }
    }
    
    func addRoadmap(_ roadmap: Roadmap) {
        // Check if a roadmap with the same title already exists
        let roadmapExists = roadmaps.contains { existingRoadmap in
            existingRoadmap.title == roadmap.title
        }
        
        // Only add if it doesn't already exist
        if !roadmapExists {
            roadmaps.append(roadmap)
            saveRoadmaps()
        }
    }
    
    func deleteRoadmap(at indexSet: IndexSet) {
        roadmaps.remove(atOffsets: indexSet)
        saveRoadmaps()
    }
    
    func updateRoadmap(_ roadmap: Roadmap) {
        if let index = roadmaps.firstIndex(where: { $0.id == roadmap.id }) {
            roadmaps[index] = roadmap
            saveRoadmaps()
        }
    }
    
    // Reset and recreate the ML roadmap
    func resetAndRecreateMLRoadmap() {
        // First remove any existing ML roadmaps
        roadmaps.removeAll { roadmap in
            roadmap.title.contains("Machine Learning")
        }
        
        // Now add a fresh one with all phases
        let newMLRoadmap = RoadmapTemplates.createMLRoadmap()
        roadmaps.append(newMLRoadmap)
        saveRoadmaps()
    }
    
    // Save roadmaps to UserDefaults
    func saveRoadmaps() {
        if let encoded = try? JSONEncoder().encode(roadmaps) {
            UserDefaults.standard.set(encoded, forKey: "savedRoadmaps")
        }
    }
    
    // Load roadmaps from UserDefaults
    func loadRoadmaps() -> [Roadmap]? {
        if let savedRoadmapsData = UserDefaults.standard.data(forKey: "savedRoadmaps"),
           let savedRoadmaps = try? JSONDecoder().decode([Roadmap].self, from: savedRoadmapsData) {
            return savedRoadmaps
        }
        return nil
    }
}
