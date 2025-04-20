import Foundation

struct SubTask: Identifiable, Codable {
    var id = UUID()
    var name: String
    var isCompleted: Bool
}

struct Task: Identifiable, Codable {
    var id = UUID()
    var name: String
    var isCompleted: Bool
    var subTasks: [SubTask]
}

struct Phase: Identifiable, Codable {
    var id = UUID()
    var name: String
    var tasks: [Task]
}

struct Roadmap: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var imageName: String
    var phases: [Phase]
}
