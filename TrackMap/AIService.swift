import Foundation

enum AIServiceError: Error {
    case missingAPIKey
    case networkError(Error)
    case invalidResponse
    case authenticationError
    case unknownError
}

class AIService {
    // MARK: - Configuration
    private static let anthropicURL = URL(string: "https://api.anthropic.com/v1/messages")!
    
    // Secure way to get API key
    private static func getAPIKey() -> String? {
        let apiKey = ProcessInfo.processInfo.environment["ANTHROPIC_API_KEY"]
        
        print("🔍 API Key Retrieved:")
        print("Key length: \(apiKey?.count ?? 0)")
        print("Key starts with 'sk-ant-': \(apiKey?.starts(with: "sk-ant-") ?? false)")
        print("Full key: \(apiKey ?? "nil")")
        
        return apiKey
    }
    
    // MARK: - Main Roadmap Generation Method
    static func generateRoadmap(
        name: String,
        description: String,
        prompt: String,
        completion: @escaping (Result<Roadmap, Error>) -> Void
    ) {
        // Validate API key
        guard let apiKey = getAPIKey() else {
            print("🚨 API Key is missing!")
            completion(.failure(AIServiceError.missingAPIKey))
            return
        }
        
        // Construct detailed prompt
        let fullPrompt = createDetailedPrompt(name: name, description: description, userInput: prompt)
        
        // Prepare URL request
        var request = URLRequest(url: anthropicURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // IMPORTANT: Trim any whitespace from the API key
        let trimmedAPIKey = apiKey.trimmingCharacters(in: .whitespacesAndNewlines)
        
        request.addValue("Bearer \(trimmedAPIKey)", forHTTPHeaderField: "Authorization")
        request.addValue(trimmedAPIKey, forHTTPHeaderField: "x-api-key")
        
        // Prepare request body
        let body: [String: Any] = [
            "model": "claude-3-opus-20240229",
            "max_tokens": 2000,
            "system": "You are an expert curriculum designer creating structured learning roadmaps.",
            "messages": [
                ["role": "user", "content": fullPrompt]
            ],
            "temperature": 0.7
        ]
        
        // Convert body to JSON data
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            print("🚨 Request body creation failed: \(error)")
            completion(.failure(AIServiceError.unknownError))
            return
        }
        
        // Perform network request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Check for network errors
            if let error = error {
                print("🚨 Network error: \(error)")
                completion(.failure(AIServiceError.networkError(error)))
                return
            }
            
            // Validate response
            guard let data = data else {
                print("🚨 No data received")
                completion(.failure(AIServiceError.invalidResponse))
                return
            }
            
            // Print raw response for debugging
            if let rawResponse = String(data: data, encoding: .utf8) {
                print("🔍 Raw Response: \(rawResponse)")
            }
            
            // Check HTTP response for authentication errors
            if let httpResponse = response as? HTTPURLResponse {
                print("🔍 HTTP Status Code: \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 401 {
                    print("🚨 Authentication Failed")
                    completion(.failure(AIServiceError.authenticationError))
                    return
                }
            }
            
            do {
                // Parse JSON response
                let jsonResponse = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                
                // Check for error in JSON response
                if let error = jsonResponse?["error"] as? [String: Any],
                   let errorMessage = error["message"] as? String {
                    print("🚨 API Error: \(errorMessage)")
                    completion(.failure(NSError(domain: "AIService", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                    return
                }
                
                // Extract AI-generated content
                guard let content = jsonResponse?["content"] as? [[String: Any]],
                      let textContent = content.first?["text"] as? String else {
                    print("🚨 Failed to extract content from response")
                    completion(.failure(AIServiceError.invalidResponse))
                    return
                }
                
                // Extract JSON from the text response
                guard let jsonStartIndex = textContent.range(of: "{")?.lowerBound,
                      let jsonEndIndex = textContent.range(of: "}", range: jsonStartIndex..<textContent.endIndex)?.upperBound else {
                    print("🚨 Failed to find JSON in response")
                    completion(.failure(AIServiceError.invalidResponse))
                    return
                }
                
                let jsonString = textContent[jsonStartIndex..<jsonEndIndex]
                
                // Parse roadmap from content
                let roadmap = try parseRoadmap(
                    json: String(jsonString),
                    name: name,
                    description: description.isEmpty ? "AI-generated roadmap for \(name)" : description
                )
                
                // Success callback
                completion(.success(roadmap))
                
            } catch {
                // Handle parsing errors
                print("🚨 Parsing error: \(error)")
                completion(.failure(AIServiceError.unknownError))
            }
        }
        
        // Start network request
        task.resume()
    }
    
    // Create a detailed, structured prompt
    private static func createDetailedPrompt(name: String, description: String, userInput: String) -> String {
        return """
        You are an expert curriculum designer creating structured learning roadmaps.

        Design a comprehensive, personalized learning roadmap for: "\(name)"
        
        Context: "\(description)"
        Learning Goal: "\(userInput)"
        
        CREATE A STRUCTURED JSON ROADMAP WITH:
        - 4-6 progressive learning phases
        - 3-5 meaningful tasks per phase
        - 2-4 specific, actionable subtasks per task
        
        REQUIREMENTS:
        1. Ensure logical skill progression
        2. Include practical, hands-on learning steps
        3. Cover fundamentals to advanced concepts
        4. Provide clear, achievable milestones
        
        OUTPUT INSTRUCTIONS:
        - Respond ONLY with a valid JSON object
        - Do NOT include any additional text or explanation
        - Follow this exact JSON structure:

        {
            "phases": [
                {
                    "name": "Phase Name",
                    "tasks": [
                        {
                            "name": "Task Name",
                            "subTasks": [
                                {"name": "Specific Subtask"},
                                {"name": "Another Specific Subtask"},
                                ...
                            ]
                        },
                        ...
                    ]
                },
                ...
            ]
        }

        BEGIN RESPONSE IN PRECISE JSON FORMAT:
        """
    }
    
    // Parse JSON into Roadmap model
    private static func parseRoadmap(json: String, name: String, description: String) throws -> Roadmap {
        guard let jsonData = json.data(using: .utf8) else {
            throw AIServiceError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        let tempRoadmap = try decoder.decode(AIRoadmapResponse.self, from: jsonData)
        
        return Roadmap(
            id: UUID(),
            title: name,
            description: description,
            imageName: "sparkles",
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
    
    // Helper structures for JSON decoding
    private struct AIRoadmapResponse: Codable {
        var phases: [AIPhase]
    }
    
    private struct AIPhase: Codable {
        var name: String
        var tasks: [AITask]
    }
    
    private struct AITask: Codable {
        var name: String
        var subTasks: [AISubTask]
    }
    
    private struct AISubTask: Codable {
        var name: String
    }
}
