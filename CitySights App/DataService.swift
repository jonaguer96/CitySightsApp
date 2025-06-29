//
//  DataService.swift
//  CitySights App
//
//  Created by Jonathan Guerrero on 6/28/25.
//

import Foundation

struct DataService {
    
    let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
    
    func businessSearch() async -> [Business] {
        
        // Check if API key exists
        guard apiKey != nil else {
            return
        }
        
        // 1. Create url
        if let url = URL(string: "https://api.yelp.com/v3/businesses/search?latitude=37.785834&longitude=-122.406417&categories=restaurants&limit=10"){
            
            // 2. Create request
            var request = URLRequest(url: url)
            request.addValue("Bearer \(apiKey!)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "accept")
            
            
            // 3. Send request
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                
                
                // 4. Parse the JSON
                let decoder = JSONDecoder()
                let result = try decoder.decode(BusinessSearch.self, from: data)
                return result.businesses
                
                
            }
            catch {
                print(error)
            }
            
        }

        
    }
    
}
