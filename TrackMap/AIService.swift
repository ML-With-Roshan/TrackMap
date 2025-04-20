//
//  AIService.swift
//  TrackMap
//
//  Created by Roshan Sai on 4/19/25.
//
import Foundation

class AIService {
    // MARK: - Configuration
    private static let apiURL = URL(string: "https://your-ai-service-endpoint.com/api")!
    private static var apiKey: String {
        // In a real app, you might store this securely or obtain it from a secure source
        // This is just a placeholder
        return "YOUR_API_KEY"
    }
    
    // MARK: - Main Generator Method
    static func generateRoadmap(name: String, description: String, prompt: String, completion: @escaping (Result<Roadmap, Error>) -> Void) {
        // Create the prompt that will be sent to the AI
        let formattedPrompt = createPrompt(name: name, description: description, userInput: prompt)
        
        // Call the AI service
        requestRoadmapFromAI(prompt: formattedPrompt) { result in
            switch result {
            case .success(let roadmapJSON):
                // Parse the AI response into a Roadmap object
                do {
                    let roadmap = try parseRoadmap(json: roadmapJSON, name: name, description: description)
                    completion(.success(roadmap))
                } catch {
                    completion(.failure(AIServiceError.parsingFailed(error)))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - AI Request
    private static func requestRoadmapFromAI(prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        // Create the request
        var request = URLRequest(url: apiURL)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create the request body
        let body: [String: Any] = [
            "prompt": prompt,
            "max_tokens": 1000,
            "temperature": 0.7,
            // Additional parameters as required by your AI service
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            completion(.failure(AIServiceError.requestCreationFailed))
            return
        }
        
        // Send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(AIServiceError.noData))
                return
            }
            
            // Parse the response
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   let firstChoice = choices.first,
                   let text = firstChoice["text"] as? String {
                    
                    completion(.success(text))
                } else {
                    completion(.failure(AIServiceError.invalidResponse))
                }
            } catch {
                completion(.failure(AIServiceError.jsonParsingFailed))
            }
        }
        
        task.resume()
    }
    
    // MARK: - Prompt Creation
    private static func createPrompt(name: String, description: String, userInput: String) -> String {
        // Create the prompt that will guide the AI to generate a roadmap
        return """
        You are an expert in learning path design and curriculum development.
        
        Please create a comprehensive learning roadmap for: "\(name)"
        
        Additional description: "\(description)"
        
        User's learning goals: "\(userInput)"
        
        Your task is to create a well-structured roadmap with the following components:
        
        1. 4-6 learning phases, each with a clear name and purpose
        2. 3-5 tasks per phase that represent key skills or knowledge areas
        3. 2-4 specific, actionable subtasks per task
        
        Please format your response as a JSON object that can be parsed into the following Swift structure:
        
        ```
        struct Roadmap {
            var phases: [Phase]
        }
        
        struct Phase {
            var name: String
            var tasks: [Task]
        }
        
        struct Task {
            var name: String
            var isCompleted: Bool  // Always false initially
            var subTasks: [SubTask]
        }
        
        struct SubTask {
            var name: String
            var isCompleted: Bool  // Always false initially
        }
        ```
        
        The response should be a valid JSON object containing only the roadmap data, with no additional explanation or commentary.
        """
    }
    
    // MARK: - Response Parsing
    private static func parseRoadmap(json: String, name: String, description: String) throws -> Roadmap {
        // This is a simplified version - in a real app, you'd need proper error handling
        // and might need to deal with different response formats
        
        // Parse the JSON string into data
        guard let jsonData = json.data(using: .utf8) else {
            throw AIServiceError.invalidData
        }
        
        // Decode the data into a temporary structure
        let decoder = JSONDecoder()
        let tempRoadmap = try decoder.decode(AIRoadmapResponse.self, from: jsonData)
        
        // Convert to your app's Roadmap model
        return Roadmap(
            id: UUID(),
            title: name,
            description: description,
            imageName: "sparkles", // Default icon for AI-generated roadmaps
            phases: tempRoadmap.phases.map { phase in
                Phase(
                    id: UUID(),
                    name: phase.name,
                    tasks: phase.tasks.map { task in
                        Task(
                            id: UUID(),
                            name: task.name,
                            isCompleted: false,
                            subTasks: task.subTasks.map { subTask in
                                SubTask(
                                    id: UUID(),
                                    name: subTask.name,
                                    isCompleted: false
                                )
                            }
                        )
                    }
                )
            }
        )
    }
    
    // MARK: - Helper Structures
    // Temporary structures for decoding the AI response
    private struct AIRoadmapResponse: Decodable {
        var phases: [AIPhase]
    }
    
    private struct AIPhase: Decodable {
        var name: String
        var tasks: [AITask]
    }
    
    private struct AITask: Decodable {
        var name: String
        var subTasks: [AISubTask]
    }
    
    private struct AISubTask: Decodable {
        var name: String
    }
    
    // MARK: - Error Types
    enum AIServiceError: Error {
        case requestCreationFailed
        case noData
        case invalidResponse
        case jsonParsingFailed
        case invalidData
        case parsingFailed(Error)
    }
}
