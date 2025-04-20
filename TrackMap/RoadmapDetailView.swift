import SwiftUI

struct RoadmapDetailView: View {
    @EnvironmentObject var appData: AppData
    @State var roadmap: Roadmap
    @State private var selectedPhaseIndex: Int = 0
    @State private var isAddingPhase: Bool = false
    @State private var isAddingTask: Bool = false
    @State private var isAddingSubTask: Bool = false
    @State private var selectedTaskIndex: Int = 0
    
    var body: some View {
        VStack {
            // Progress bar
            ProgressView("Roadmap Progress", value: progress, total: totalTasks)
                .progressViewStyle(LinearProgressViewStyle())
                .padding()
            
            if roadmap.phases.isEmpty {
                // Empty state view for no phases
                VStack {
                    Image(systemName: "list.bullet.clipboard")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray)
                        .padding()
                    
                    Text("No Phases Yet")
                        .font(.title)
                        .foregroundColor(.gray)
                    
                    Button(action: {
                        isAddingPhase = true
                    }) {
                        Text("Add First Phase")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .padding()
            } else {
                // Phase navigation buttons
                HStack {
                    Button(action: {
                        if selectedPhaseIndex > 0 {
                            selectedPhaseIndex -= 1
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(selectedPhaseIndex > 0 ? .blue : .gray)
                    }
                    .disabled(selectedPhaseIndex <= 0)
                    .padding()
                    
                    Menu {
                        ForEach(0..<roadmap.phases.count, id: \.self) { index in
                            Button(action: {
                                selectedPhaseIndex = index
                            }) {
                                Text(roadmap.phases[index].name)
                                    .foregroundColor(.primary)
                            }
                        }
                    } label: {
                        Text(roadmap.phases[selectedPhaseIndex].name)
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 20)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        if selectedPhaseIndex < roadmap.phases.count - 1 {
                            selectedPhaseIndex += 1
                        }
                    }) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(selectedPhaseIndex < roadmap.phases.count - 1 ? .blue : .gray)
                    }
                    .disabled(selectedPhaseIndex >= roadmap.phases.count - 1)
                    .padding()
                }
                
                // Add task button
                Button(action: {
                    isAddingTask = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle")
                        Text("Add Task")
                    }
                    .padding(8)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
                }
                .padding(.bottom, 10)
                
                // Current phase content
                if selectedPhaseIndex < roadmap.phases.count {
                    let currentPhase = roadmap.phases[selectedPhaseIndex]
                    
                    if currentPhase.tasks.isEmpty {
                        Text("No tasks in this phase")
                            .foregroundColor(.gray)
                            .padding(.top, 50)
                    } else {
                        List {
                            ForEach(currentPhase.tasks.indices, id: \.self) { taskIndex in
                                let task = currentPhase.tasks[taskIndex]
                                Section(header:
                                    HStack {
                                        Text(task.name).font(.headline)
                                        Spacer()
                                        Button(action: {
                                            selectedTaskIndex = taskIndex
                                            isAddingSubTask = true
                                        }) {
                                            Image(systemName: "plus.circle.fill")
                                                .foregroundColor(.blue)
                                        }
                                        .buttonStyle(BorderlessButtonStyle())
                                    }
                                ) {
                                    ForEach(task.subTasks) { subTask in
                                        HStack {
                                            Text(subTask.name)
                                            Spacer()
                                            Image(systemName: subTask.isCompleted ? "checkmark.circle.fill" : "circle")
                                                .foregroundColor(subTask.isCompleted ? .green : .gray)
                                                .onTapGesture {
                                                    markSubTaskComplete(subTask, task: task)
                                                }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    Text("Error: Selected phase is out of range")
                        .foregroundColor(.red)
                        .padding()
                }
            }
        }
        .navigationTitle(roadmap.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isAddingPhase = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear {
            // Ensure selected phase is valid
            if roadmap.phases.isEmpty {
                selectedPhaseIndex = 0
            } else if selectedPhaseIndex >= roadmap.phases.count {
                selectedPhaseIndex = 0
            }
        }
        .sheet(isPresented: $isAddingPhase) {
            AddPhaseView { phaseName in
                let newPhase = Phase(id: UUID(), name: phaseName, tasks: [])
                roadmap.phases.append(newPhase)
                selectedPhaseIndex = roadmap.phases.count - 1
                updateRoadmap()
            }
        }
        .sheet(isPresented: $isAddingTask) {
            AddTaskView { taskName in
                if !roadmap.phases.isEmpty {
                    let newTask = Task(id: UUID(), name: taskName, isCompleted: false, subTasks: [])
                    roadmap.phases[selectedPhaseIndex].tasks.append(newTask)
                    updateRoadmap()
                }
            }
        }
        .sheet(isPresented: $isAddingSubTask) {
            AddSubTaskView { subTaskName in
                if !roadmap.phases.isEmpty && !roadmap.phases[selectedPhaseIndex].tasks.isEmpty {
                    let newSubTask = SubTask(id: UUID(), name: subTaskName, isCompleted: false)
                    roadmap.phases[selectedPhaseIndex].tasks[selectedTaskIndex].subTasks.append(newSubTask)
                    updateRoadmap()
                }
            }
        }
    }
    
    var totalTasks: Double {
        let total = roadmap.phases.flatMap { $0.tasks }.flatMap { $0.subTasks }.count
        return total > 0 ? Double(total) : 1.0
    }
    
    var progress: Double {
        let completedTasks = roadmap.phases.flatMap { $0.tasks }.flatMap { $0.subTasks }.filter { $0.isCompleted }.count
        return Double(completedTasks)
    }
    
    func markSubTaskComplete(_ subTask: SubTask, task: Task) {
        if let phaseIndex = roadmap.phases.firstIndex(where: { $0.id == roadmap.phases[selectedPhaseIndex].id }),
           let taskIndex = roadmap.phases[phaseIndex].tasks.firstIndex(where: { $0.id == task.id }),
           let subTaskIndex = roadmap.phases[phaseIndex].tasks[taskIndex].subTasks.firstIndex(where: { $0.id == subTask.id }) {
            
            roadmap.phases[phaseIndex].tasks[taskIndex].subTasks[subTaskIndex].isCompleted.toggle()
            updateRoadmap()
        }
    }
    
    func updateRoadmap() {
        // Update the roadmap in the app data
        appData.updateRoadmap(roadmap)
    }
}
