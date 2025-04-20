import Foundation

class AIService {
    // MARK: - Configuration
    private static let useDevelopmentMode = true // Set to true to use placeholder data instead of API
    
    private static let apiURL = URL(string: "https://api.anthropic.com/v1/messages")!
    private static var apiKey: String {
        return "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"
    }
    
    // MARK: - Main Generator Method
    static func generateRoadmap(name: String, description: String, prompt: String, completion: @escaping (Result<Roadmap, Error>) -> Void) {
        // In development mode, use placeholder data instead of API call
        if useDevelopmentMode {
            // Add a small delay to simulate network request
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                let roadmap = createSampleRoadmap(name: name, description: description, topic: prompt)
                // Ensure we're on the main thread when calling completion
                DispatchQueue.main.async {
                    completion(.success(roadmap))
                }
            }
            return
        }
        
        // Create the prompt that will be sent to the AI
        let formattedPrompt = createPrompt(name: name, description: description, userInput: prompt)
        
        // Call the AI service
        requestRoadmapFromAI(prompt: formattedPrompt) { result in
            // Ensure we're on the main thread when calling completion
            DispatchQueue.main.async {
                switch result {
                case .success(let roadmapJSON):
                    // Parse the AI response into a Roadmap object
                    do {
                        let roadmap = try parseRoadmap(json: roadmapJSON, name: name, description: description)
                        completion(.success(roadmap))
                    } catch {
                        print("Error parsing roadmap: \(error)")
                        completion(.failure(AIServiceError.parsingFailed(error)))
                    }
                    
                case .failure(let error):
                    print("API request error: \(error)")
                    completion(.failure(error))
                }
            }
        }
    }
    
    // MARK: - Development Mode Sample Roadmap
    private static func createSampleRoadmap(name: String, description: String, topic: String) -> Roadmap {
        // Create a sample roadmap based on the name/topic
        let formattedDescription = description.isEmpty ? "AI-generated roadmap for \(name)" : description
        
        // Create phases based on the topic
        var phases: [Phase] = []
        
        // Phase 1: Always fundamentals
        phases.append(
            Phase(
                id: UUID(),
                name: "Phase 1: \(name) Fundamentals",
                tasks: [
                    Task(
                        id: UUID(),
                        name: "Basic Concepts",
                        isCompleted: false,
                        subTasks: [
                            SubTask(id: UUID(), name: "Understand core terminology", isCompleted: false),
                            SubTask(id: UUID(), name: "Study history and background", isCompleted: false),
                            SubTask(id: UUID(), name: "Set up learning environment", isCompleted: false)
                        ]
                    ),
                    Task(
                        id: UUID(),
                        name: "Environment Setup",
                        isCompleted: false,
                        subTasks: [
                            SubTask(id: UUID(), name: "Install required tools", isCompleted: false),
                            SubTask(id: UUID(), name: "Configure development environment", isCompleted: false)
                        ]
                    ),
                    Task(
                        id: UUID(),
                        name: "First Steps",
                        isCompleted: false,
                        subTasks: [
                            SubTask(id: UUID(), name: "Complete beginner tutorial", isCompleted: false),
                            SubTask(id: UUID(), name: "Build a simple practice project", isCompleted: false)
                        ]
                    )
                ]
            )
        )
        
        // Phase 2: Intermediate skills
        phases.append(
            Phase(
                id: UUID(),
                name: "Phase 2: Intermediate \(name)",
                tasks: [
                    Task(
                        id: UUID(),
                        name: "Advanced Concepts",
                        isCompleted: false,
                        subTasks: [
                            SubTask(id: UUID(), name: "Study intermediate techniques", isCompleted: false),
                            SubTask(id: UUID(), name: "Apply concepts to real problems", isCompleted: false),
                            SubTask(id: UUID(), name: "Complete intermediate exercises", isCompleted: false)
                        ]
                    ),
                    Task(
                        id: UUID(),
                        name: "Build a Medium Project",
                        isCompleted: false,
                        subTasks: [
                            SubTask(id: UUID(), name: "Plan project architecture", isCompleted: false),
                            SubTask(id: UUID(), name: "Implement core functionality", isCompleted: false),
                            SubTask(id: UUID(), name: "Add advanced features", isCompleted: false)
                        ]
                    )
                ]
            )
        )
        
        // Phase 3: Advanced techniques
        phases.append(
            Phase(
                id: UUID(),
                name: "Phase 3: Advanced \(name) Mastery",
                tasks: [
                    Task(
                        id: UUID(),
                        name: "Expert-Level Concepts",
                        isCompleted: false,
                        subTasks: [
                            SubTask(id: UUID(), name: "Study advanced patterns and techniques", isCompleted: false),
                            SubTask(id: UUID(), name: "Understand optimization strategies", isCompleted: false)
                        ]
                    ),
                    Task(
                        id: UUID(),
                        name: "Build a Complex Project",
                        isCompleted: false,
                        subTasks: [
                            SubTask(id: UUID(), name: "Design scalable architecture", isCompleted: false),
                            SubTask(id: UUID(), name: "Implement using best practices", isCompleted: false),
                            SubTask(id: UUID(), name: "Deploy to production", isCompleted: false)
                        ]
                    ),
                    Task(
                        id: UUID(),
                        name: "Contribute to Community",
                        isCompleted: false,
                        subTasks: [
                            SubTask(id: UUID(), name: "Share knowledge through blog posts", isCompleted: false),
                            SubTask(id: UUID(), name: "Participate in open source", isCompleted: false)
                        ]
                    )
                ]
            )
        )
        
        // Create the roadmap object
        return Roadmap(
            id: UUID(),
            title: name,
            description: formattedDescription,
            imageName: "sparkles",
            phases: phases
        )
    }
    
    // MARK: - AI Request
    private static func requestRoadmapFromAI(prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        // Create the request
        var request = URLRequest(url: apiURL)
        request.httpMethod = "POST"
        
        // Authentication for Anthropic API
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.addValue("2023-06-01", forHTTPHeaderField: "anthropic-version")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create the request body according to Anthropic's API spec
        let body: [String: Any] = [
            "model": "claude-3-opus-20240229",
            "max_tokens": 4000,
            "temperature": 0.7,
            "messages": [
                ["role": "user", "content": prompt]
            ]
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
            
            // Parse the response according to Anthropic's API response format
            do {
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                
                // Check for API errors first
                if let errorObject = json?["error"] as? [String: Any],
                   let errorMessage = errorObject["message"] as? String {
                    completion(.failure(NSError(domain: "AnthropicAPI", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                    return
                }
                
                // Try different response formats based on Anthropic's API structure
                if let content = json?["content"] as? [[String: Any]],
                   let firstContent = content.first,
                   let text = firstContent["text"] as? String {
                    // Standard format for messages API
                    completion(.success(text))
                    return
                }
                
                if let completionText = json?["completion"] as? String {
                    // Older format for completions API
                    completion(.success(completionText))
                    return
                }
                
                // If we get here, try to send raw response as fallback
                if let rawResponse = String(data: data, encoding: .utf8) {
                    completion(.success(rawResponse))
                    return
                }
                
                completion(.failure(AIServiceError.invalidResponse))
                
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
        ONLY RETURN THE JSON OBJECT, nothing else. No markdown formatting, no explanations, just the raw JSON.
        """
    }
    
    // MARK: - Response Parsing
    private static func parseRoadmap(json: String, name: String, description: String) throws -> Roadmap {
        // Extract the JSON part from the response, in case Claude includes text outside the JSON
        let jsonString = extractJSONFromResponse(json)
        
        // Parse the JSON string into data
        guard let jsonData = jsonString.data(using: .utf8) else {
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
    
    // Helper method to extract JSON from the AI response
    private static func extractJSONFromResponse(_ response: String) -> String {
        // Try to find JSON between curly braces
        do {
            let jsonRegex = try NSRegularExpression(pattern: "\\{[^\\{\\}]*(?:\\{[^\\{\\}]*\\}[^\\{\\}]*)*\\}")
            let nsString = response as NSString
            let matches = jsonRegex.matches(in: response, range: NSRange(location: 0, length: nsString.length))
            
            if let match = matches.last {  // Take the last (usually largest) JSON object
                let jsonString = nsString.substring(with: match.range)
                return jsonString
            }
        } catch {
            // Silently fail and try the next method
        }
        
        // Fallback: simple curly brace matching
        if let startIndex = response.firstIndex(of: "{"),
           let endIndex = response.lastIndex(of: "}") {
            let jsonSubstring = response[startIndex...endIndex]
            return String(jsonSubstring)
        }
        
        // If all else fails, try to add structure ourselves
        return "{ \"phases\": [] }"
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
    enum AIServiceError: Error, LocalizedError {
        case requestCreationFailed
        case noData
        case invalidResponse
        case jsonParsingFailed
        case invalidData
        case parsingFailed(Error)
        
        var errorDescription: String? {
            switch self {
            case .requestCreationFailed:
                return "Failed to create the API request"
            case .noData:
                return "No data received from the API"
            case .invalidResponse:
                return "Invalid response format from the API"
            case .jsonParsingFailed:
                return "Failed to parse JSON response"
            case .invalidData:
                return "Invalid data in the response"
            case .parsingFailed(let error):
                return "Failed to parse roadmap data: \(error.localizedDescription)"
            }
        }
    }
}
