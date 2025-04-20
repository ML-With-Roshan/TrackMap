import Foundation

struct SubTask: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var isCompleted: Bool
    
    static func == (lhs: SubTask, rhs: SubTask) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.isCompleted == rhs.isCompleted
    }
}

struct Task: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var isCompleted: Bool
    var subTasks: [SubTask]
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.isCompleted == rhs.isCompleted &&
               lhs.subTasks == rhs.subTasks
    }
}

struct Phase: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var tasks: [Task]
    
    static func == (lhs: Phase, rhs: Phase) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.tasks == rhs.tasks
    }
}

struct Roadmap: Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String
    var description: String
    var imageName: String
    var phases: [Phase]
    
    static func == (lhs: Roadmap, rhs: Roadmap) -> Bool {
        return lhs.id == rhs.id &&
               lhs.title == rhs.title &&
               lhs.description == rhs.description &&
               lhs.imageName == rhs.imageName &&
               lhs.phases == rhs.phases
    }
}
