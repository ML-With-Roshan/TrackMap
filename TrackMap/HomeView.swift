import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appData: AppData
    @State private var showingAddRoadmap = false
    
    var body: some View {
        NavigationView {
            VStack {
                if appData.roadmaps.isEmpty {
                    EmptyStateView(showAddRoadmap: $showingAddRoadmap)
                } else {
                    List {
                        ForEach(appData.roadmaps) { roadmap in
                            NavigationLink(destination: RoadmapDetailView(roadmap: roadmap).environmentObject(appData)) {
                                RoadmapRow(roadmap: roadmap)
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    if let index = appData.roadmaps.firstIndex(where: { $0.id == roadmap.id }) {
                                        appData.deleteRoadmap(at: IndexSet(integer: index))
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("My Roadmaps")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddRoadmap = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddRoadmap) {
                AddRoadmapView().environmentObject(appData)
            }
        }
    }
}

struct EmptyStateView: View {
    @Binding var showAddRoadmap: Bool
    @EnvironmentObject var appData: AppData
    
    var body: some View {
        VStack {
            Image(systemName: "map")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
                .padding()
            
            Text("No Roadmaps Yet")
                .font(.title)
                .foregroundColor(.gray)
            
            Text("Create your first learning roadmap")
                .foregroundColor(.gray)
            
            VStack(spacing: 15) {
                Button(action: {
                    showAddRoadmap = true
                }) {
                    Text("Create Custom Roadmap")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 40)
            .padding(.top, 20)
        }
        .padding()
    }
}

struct RoadmapRow: View {
    let roadmap: Roadmap
    
    var body: some View {
        HStack {
            Image(systemName: roadmap.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.blue)
                .padding(.trailing, 10)
            
            VStack(alignment: .leading) {
                Text(roadmap.title)
                    .font(.headline)
                Text(roadmap.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 5)
    }
}
